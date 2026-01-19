# Stage 1: Base - Install all dependencies
FROM node:22-alpine AS base
WORKDIR /app
COPY package*.json ./
RUN npm ci

# Stage 2: Linting
FROM base AS lint
COPY . .
RUN npm run lint

# Stage 3: Testing
FROM base AS test
COPY . .
RUN npm test

# Stage 4: Dependencies for Production
FROM base AS production-deps
RUN npm ci --only=production
RUN npm audit --audit-level=high || true

# Stage 5: Final Production Image
FROM node:22-alpine
WORKDIR /app

# Copy production dependencies
COPY --from=production-deps /app/node_modules ./node_modules
# Copy source code
COPY src/ ./

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

USER nodejs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

# Start application
CMD ["node", "index.js"]
