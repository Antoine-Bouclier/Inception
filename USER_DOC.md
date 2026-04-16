# User & Administrator Guide

This guide provides the essential information needed to deploy, manage, and verify the services.

1. Services Overview

The stack is a containerized infrastructure designed to provide a secure web environment using Docker. It contains the following services:

- Nginx: It's an HTTP web server, reverse proxy. Acts as the entry point, handling TLS encryption and routing traffic.
- MariaDB: The relational database used to store all the data needed for our website.
- Wordpress: The Content Management System serving the web frontend.

2. Managing the project

The stack is managed using **Docker Compose**. Ensure you are at the root of the project, where the Makefile is located.

## Starting the services

To build and start the project:

```bash
make
```

To restart the containers after a `make stop`

```bash
make start
```

To rebuild the containers after a `make down`

```bash
make up
```

## Stopping the services

To stop the services while keeping the data intact:

```bash
make stop
```

To stop and removes the containers but keeping the data intact:

```bash
make down
```

To stop and remove the containers and the data:

```bash
make fclean
```

3. Accessing the website and administrator panel

Once the services are running, the interfaces is available via your web browser:

| Interface | URL | Description |
| :--- | :--- | :--- |
| **Public Website** | `https://abouclie.42.fr` | The main wordpress landing page. |
| **Admin Panel** | `https://abouclie.42.fr/wp-admin` | The Wordpress dashboard for content management. |

**Note**: Since the site uses a self-signed certificate for local development, your browser may display a security warning. You can safely click "Advanced" and "Proceed" to continue.

4. Credentials & Security

For security reasons, sensitive information is not hardcoded. Credentials are managed via environment Variables found in the `.env` file and the secrets directory for the password.

The `secrets` directory is located at the root of the project and the `.env` file is located in the `srcs` directory

5. Health Check & Verification

To ensure all services are operating as expected, use the following commands:

## Status Check

Verify that all containers are up:

```bash
docker ps
```


