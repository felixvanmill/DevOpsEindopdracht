# DevOps Eindopdracht

<!-- Badges -->
![CI](https://github.com/felixvanmill/DevOpsEindopdracht/actions/workflows/ci.yml/badge.svg?branch=main)
![CD](https://github.com/felixvanmill/DevOpsEindopdracht/actions/workflows/cd.yml/badge.svg?branch=main)

## Quick Start

### Lokaal draaien

```bash
# Installeer dependencies (reproduceerbaar)
npm ci

# Start development server
npm run dev

# Of: start production server
npm start
```

### Docker Compose (app + monitoring)

```bash
# Start stack (app + Prometheus + Grafana)
docker compose up -d --build
```

- App: http://localhost:3000
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3001 (admin/admin)

### Docker (alleen app)

```bash
# Build image
docker build -t devopseindopdracht .

# Run container
docker run -p 3000:3000 devopseindopdracht
```

### Van GHCR (image uit CD pipeline)

```bash
# Pull image
docker pull ghcr.io/felixvanmill/devopseindopdracht:latest

# Run container
docker run -p 3000:3000 ghcr.io/felixvanmill/devopseindopdracht:latest
```

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/` | Welcome message |
| GET | `/health` | Health check |
| GET | `/metrics` | Prometheus metrics |
| GET | `/api/items` | Get all items |
| GET | `/api/items/:id` | Get item by ID |
| POST | `/api/items` | Create new item |

## Tests

```bash
# Run tests
npm test

# Run with coverage
npm run test:coverage
```

## Project Structure

```text
├── .github/
│   └── workflows/
│       ├── ci.yml          # CI workflow
│       └── cd.yml          # CD workflow (build + push naar GHCR)
├── src/
│   ├── index.js            # Express app
│   └── data.js             # Data module
├── tests/
│   ├── api.test.js         # API tests
│   └── data.test.js        # Data module tests
├── prometheus/             # Prometheus config
├── grafana/                # Grafana provisioning
├── docker-compose.yml      # App + monitoring stack
├── Dockerfile              # Multi-stage Docker build
├── package.json
└── README.md
```
