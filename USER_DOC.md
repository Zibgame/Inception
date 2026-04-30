# USER_DOC.md

# User Documentation

## Overview

This project provides a secure Docker-based web infrastructure composed of:

* **NGINX**: HTTPS reverse proxy (TLSv1.2/TLSv1.3 only)
* **WordPress + PHP-FPM**: Website service
* **MariaDB**: Database service

---

## Starting the Project

To build and launch all services:

```bash
make
```

---

## Stopping the Project

To stop all containers:

```bash
make down
```

---

## Cleaning Docker Resources

To remove containers and images:

```bash
make clean
```

To fully reset infrastructure:

```bash
make fclean
```

---

## Accessing the Website

### Main website:

```text
https://<your_login>.42.fr
```

### WordPress admin panel:

```text
https://<your_login>.42.fr/wp-admin
```

---

## Credentials Management

Credentials are stored securely using:

* `.env`
* local secret files (if configured)

### Important variables:

* WordPress admin username
* WordPress admin password
* Database user credentials
* MariaDB root password

---

## Checking Services Status

List running containers:

```bash
docker ps
```

Check logs:

```bash
docker compose logs
```

---

## Persistent Data

Project data is stored in:

```text
/home/<login>/data/
```

Contains:

* WordPress website files
* MariaDB database files

---

## Troubleshooting

### Website unavailable:

* Check domain resolution in `/etc/hosts`
* Verify containers are running
* Verify port 443 accessibility

### Database issues:

* Check MariaDB logs
* Verify `.env` credentials

---
