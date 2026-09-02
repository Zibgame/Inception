# DEV_DOC.md

# Developer Documentation

## Prerequisites

Required:

* Linux Virtual Machine
* Docker
* Docker Compose
* Make

---

## Initial Environment Setup

### 1. Clone repository

```bash
git clone <repo_url>
cd Inception
```

### 2. Configure domain

Add to `/etc/hosts`:

```bash
127.0.0.1 <login>.42.fr
```

### 3. Configure `.env`

Example:

```env
DOMAIN_NAME=<login>.42.fr
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=<password>
MYSQL_ROOT_PASSWORD=<root_password>
WP_ADMIN_USER=<admin_user>
WP_ADMIN_PASSWORD=<admin_password>
WP_ADMIN_EMAIL=<admin_email>
WP_USER=<user>
WP_USER_PASSWORD=<user_password>
WP_USER_EMAIL=<user_email>
```

---

## Build and Launch

```bash
make
```

---

## Useful Commands

### Stop:

```bash
make down
```

### Clean:

```bash
make clean
```

### Full reset:

```bash
make fclean
```

### Rebuild:

```bash
make re
```

---

## Docker Management

### Running containers:

```bash
docker ps
```

### Logs:

```bash
docker compose logs
```

### Inspect volumes:

```bash
docker volume ls
```

---

## Data Persistence

Persistent data location:

```text
/home/<login>/data/
```

### Structure:

* `/home/<login>/data/mariadb`
* `/home/<login>/data/wordpress`

---

## Project Structure

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
```

---

## Service Details

### MariaDB:

* Database initialization script
* User/database creation automation

### WordPress:

* WP-CLI automated installation
* User creation
* PHP-FPM service

### NGINX:

* Reverse proxy
* SSL/TLS termination
* HTTPS only

---

## Security Notes

* No credentials inside Dockerfiles
* `.env` required
* Git ignore sensitive files
* TLS enforced
* Docker network isolation

---

## Common Maintenance

### Reinitialize project:

```bash
docker compose down -v
sudo rm -rf /home/<login>/data/*
make
```

### SSL renewal:

Regenerate certificates if needed.

---

## Evaluation Readiness

Before defense:

* Verify all services run
* Verify HTTPS works
* Verify users exist
* Verify persistence after reboot
* Be able to explain architecture

