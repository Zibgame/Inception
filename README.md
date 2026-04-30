*This project has been created as part of the 42 curriculum by zcadinot.*

# Inception

## Description

Inception is a system administration project from the 42 curriculum focused on designing and deploying a secure, containerized web infrastructure using Docker and Docker Compose inside a virtual machine.

The goal is to build a complete multi-service architecture from scratch using custom Dockerfiles only, without relying on prebuilt images (except the base Debian or Alpine image).

### Mandatory infrastructure includes:

* **NGINX** as the sole HTTPS entrypoint (TLSv1.2/TLSv1.3 only)
* **WordPress + PHP-FPM** for website hosting
* **MariaDB** for database management
* **Docker volumes** for persistent WordPress and database storage
* **Docker network** for isolated inter-container communication

### Main design choices:

* Dedicated container per service
* Secure SSL/TLS configuration
* Persistent data management through Docker named volumes
* Environment-based configuration
* Automated deployment with Makefile
* Custom initialization scripts for automation

### Sources included in this project:

* Custom Dockerfiles
* NGINX configuration
* MariaDB initialization scripts
* WordPress installation scripts
* Docker Compose orchestration
* Environment variable management

---

## Instructions

### Prerequisites

* Linux Virtual Machine
* Docker
* Docker Compose
* Make

### Domain configuration

Add your domain to `/etc/hosts`:

```bash
127.0.0.1 zcadinot.42.fr
```

### Environment setup

Configure your `.env` file:

```env
DOMAIN_NAME=zcadinot.42.fr
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=<your_password>
MYSQL_ROOT_PASSWORD=<your_root_password>
```

### Build and launch

```bash
make
```

### Stop containers

```bash
make down
```

### Clean containers/images

```bash
make clean
```

### Full reset

```bash
make fclean
```

### Rebuild from scratch

```bash
make re
```

---

## Project Architecture

```text
Client Browser
     |
 HTTPS (443)
     |
   NGINX
     |
 WordPress + PHP-FPM
     |
   MariaDB
```

### Docker Components:

* **NGINX container**: reverse proxy + SSL termination
* **WordPress container**: PHP application
* **MariaDB container**: relational database
* **Named volumes**:

  * WordPress files
  * MariaDB data
* **Custom bridge network**: secure internal communication

---

## Technical Choices

### Virtual Machines vs Docker

| Virtual Machines         | Docker               |
| ------------------------ | -------------------- |
| Full OS emulation        | Shared host kernel   |
| Heavy resource usage     | Lightweight          |
| Slower boot times        | Fast startup         |
| Larger storage footprint | Minimal footprint    |
| Strong isolation         | Efficient deployment |

**Choice:** Docker was selected for modularity, scalability, and deployment efficiency.

---

### Secrets vs Environment Variables

| Environment Variables | Docker Secrets              |
| --------------------- | --------------------------- |
| Easy to configure     | More secure                 |
| Less secure           | Better credential isolation |
| Good for basic config | Ideal for production        |

**Choice:** Environment variables are mandatory for project compliance, while Docker secrets are preferred for sensitive production credentials.

---

### Docker Network vs Host Network

| Docker Network    | Host Network         |
| ----------------- | -------------------- |
| Isolated          | Direct host exposure |
| More secure       | Less secure          |
| Service discovery | Simpler but risky    |

**Choice:** Docker bridge network ensures service isolation and security.

---

### Docker Volumes vs Bind Mounts

| Docker Volumes        | Bind Mounts         |
| --------------------- | ------------------- |
| Managed by Docker     | Host-dependent      |
| Portable              | Less portable       |
| Safer for persistence | More manual control |

**Choice:** Docker named volumes comply with project requirements and improve persistence management.

---

## Security

* HTTPS only
* TLSv1.2 / TLSv1.3
* No port 80 exposure
* No hardcoded credentials in Dockerfiles
* Environment variables used
* Docker secrets recommended
* Isolated Docker network
* Persistent storage separation
* Automatic container restart policies

---

## Project Structure

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
├── secrets/
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── mariadb/
        ├── nginx/
        └── wordpress/
```

---

## Resources

### Official Documentation

* Docker Documentation
* Docker Compose Documentation
* NGINX SSL Configuration Guide
* MariaDB Documentation
* WordPress CLI Documentation
* Debian Documentation
* Alpine Linux Documentation

### Helpful Topics

* PID 1 behavior in containers
* Docker volume persistence
* TLS certificate generation
* PHP-FPM configuration
* Reverse proxy architecture

### AI Usage Disclosure

AI tools were used for:

* Understanding Docker concepts
* Improving infrastructure architecture
* Debugging containerization issues
* Documentation structuring
* Learning security best practices

All AI-generated material was critically reviewed, manually tested, and fully understood before integration.

---

## Author

**zcadinot**
42 School - Inception Project
