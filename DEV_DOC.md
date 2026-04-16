# Developer Documentation - Inception Stack

This documentation is intended for developers who wish to set up, maintain, or modify the Inception infrastructure.

---

## 1. Environment Setup

### Prerequisites
- **Operating System:** Linux (Debian-based recommended) or a Virtual Machine.
- **Docker:** Version 20.10+
- **Docker Compose:** V2 plugin
- **Make:** Standard build utility

### Project Structure
```text
├── Makefile                      # Main automation script
├── secrets/                      # Sensitive passwords (db_root, wp_user, etc.)
└── srcs/
    ├── .env                      # Global environment variables
    ├── docker-compose.yml        # Infrastructure orchestration
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   ├── conf/             # custom .cnf files
        │   └── tools/            # setup.sh (entrypoint script)
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/             # nginx.conf (SSL/TLS config)
        └── wordpress/
            ├── Dockerfile
            ├── conf/             # php-fpm configuration
            └── tools/            # wp_setup.sh (WP-CLI install script)
