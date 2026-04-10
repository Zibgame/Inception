*This project has been created as part of the 42 curriculum by zcadinot.*

# 🚀 Inception

## 📌 Description

Inception is a system administration project focused on building a secure and modular infrastructure using Docker. The objective is to set up multiple services in isolated containers and connect them through a Docker network.

The infrastructure includes:

* 🌐 NGINX (HTTPS only)
* 🧠 WordPress with PHP-FPM
* 🗄️ MariaDB database

Each service runs in its own container and communicates through a dedicated Docker network. Persistent data is managed using Docker volumes.

---

## ⚙️ Instructions

### 🔧 Prerequisites

* Docker
* Docker Compose
* Virtual Machine (required by project rules)

### ▶️ Build and Run

```bash
make
```

### ⏹️ Stop

```bash
make down
```

### 🧹 Clean

```bash
make clean
```

---

## 🏗️ Architecture

```
Client (HTTPS :443)
        ↓
     NGINX 🔒
        ↓
 WordPress (PHP-FPM)
        ↓
     MariaDB 🗄️
```

* 🔗 Docker Network: connects all services
* 💾 Volumes:

  * WordPress files
  * Database data

---

## 🔐 Security

* HTTPS only (TLSv1.2 / TLSv1.3)
* No credentials in Dockerfiles
* Environment variables stored in `.env`
* Sensitive data managed with Docker secrets

---

## 📚 Technical Choices

### 🖥️ Virtual Machines vs Docker

* Virtual Machines emulate full systems (heavy, slower)
* Docker uses containers (lightweight, fast, efficient)

### 🔑 Secrets vs Environment Variables

* Environment variables: easy but less secure
* Docker secrets: secure storage for sensitive data

### 🌐 Docker Network vs Host Network

* Docker Network: isolated, secure communication
* Host Network: direct access, less secure

### 💾 Volumes vs Bind Mounts

* Volumes: managed by Docker, portable
* Bind mounts: depend on host filesystem

---

## 📦 Project Structure

```
.
├── Makefile
├── secrets/
├── srcs/
│   ├── .env
│   ├── docker-compose.yml
│   └── requirements/
│       ├── mariadb/
│       ├── nginx/
│       └── wordpress/
```

---

## 📖 Resources

* Docker Official Documentation
* NGINX Documentation
* MariaDB Documentation
* WordPress Documentation

### 🤖 AI Usage

AI was used for:

* Understanding Docker concepts
* Structuring the architecture
* Debugging configuration issues

All generated content was reviewed, tested, and fully understood before integration.

---

## ✅ Features

* 🔒 Secure HTTPS setup
* ⚡ Containerized services
* 🔄 Automatic restart on failure
* 💾 Persistent storage

---

## 🧪 Validation Checklist

* All containers run without errors
* Website accessible via HTTPS
* Database persists after restart
* No hardcoded credentials

---

## 👨‍💻 Author

* zcadinot
