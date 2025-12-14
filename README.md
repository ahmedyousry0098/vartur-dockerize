# Vartur Docker Services

This directory contains the Docker Compose configuration for Vartur's development infrastructure.

## Setup

Copy `docker-compose.yml` to your project root directory:

```bash
cp docker/docker-compose.yml ./docker-compose.yml
```

Or run directly from this directory:

```bash
docker compose -f docker/docker-compose.yml up -d
```

## Quick Start

```bash
# Start all services
docker compose up -d

# Start specific service(s)
docker compose up -d mysql redis

# Stop all services
docker compose down

# Stop and remove volumes (⚠️ deletes all data)
docker compose down -v
```

## Services

| Service         | Port(s)       | Credentials                          |
|-----------------|---------------|--------------------------------------|
| MySQL           | 3306          | `root` / `mysql`                     |
| MongoDB         | 27017         | `root` / `mongo`                     |
| Redis           | 6379          | No auth                              |
| RabbitMQ        | 5672, 15672   | `guest` / `guest`                    |
| Elasticsearch   | 9200, 9300    | No auth                              |
| Kibana          | 5601          | No auth                              |

## Connection Examples

### MySQL

```bash
# CLI
mysql -h 127.0.0.1 -P 3306 -u root -pmysql

# Connection string
mysql://root:mysql@127.0.0.1:3306/your_database
```

**MySQL Workbench:**
- Host: `127.0.0.1`
- Port: `3306`
- Username: `root`
- Password: `mysql`

### MongoDB

```bash
# CLI
mongosh "mongodb://root:mongo@127.0.0.1:27017"

# Connection string
mongodb://root:mongo@127.0.0.1:27017/your_database?authSource=admin
```

### Redis

```bash
redis-cli -h 127.0.0.1 -p 6379
```

### RabbitMQ

- **AMQP**: `amqp://guest:guest@127.0.0.1:5672`
- **Management UI**: http://localhost:15672

### Elasticsearch

```bash
curl http://localhost:9200
```

### Kibana

Open http://localhost:5601

## Health Checks

All services include health checks. View status:

```bash
docker compose ps
```

Wait for a specific service to be healthy:

```bash
docker compose up -d mysql
docker compose exec mysql mysqladmin ping -h localhost -u root -pmysql
```

## Volumes

Data is persisted in named volumes:

| Volume                | Service       |
|-----------------------|---------------|
| `vartur_mysql`        | MySQL         |
| `vartur_mongo`        | MongoDB       |
| `vartur_redis`        | Redis         |
| `vartur_rabbitmq`     | RabbitMQ      |
| `vartur_elasticsearch`| Elasticsearch |

### Reset Data

```bash
# Remove specific volume
docker volume rm vartur_mysql

# Remove all Vartur volumes
docker volume rm vartur_mysql vartur_mongo vartur_redis vartur_rabbitmq vartur_elasticsearch
```

## Troubleshooting

### MySQL "Access denied" error

If you get `Access denied for user 'root'@'192.168.65.1'`:

1. Remove the MySQL volume and recreate:
   ```bash
   docker compose down
   docker volume rm vartur_mysql
   docker compose up -d mysql
   ```

2. Wait ~30 seconds for MySQL to initialize, then connect.

### Port already in use

Check what's using the port:

```bash
lsof -i :3306
```

Stop the conflicting service or change the port in `docker-compose.yml`.

### View logs

```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f mysql
```
