# Inception - 42 Project

*This project has been created as part of the 42 curriculum by abouclie.*

## 1. Description
Its primary goal is to broaden system administration knowledge by managing a complete infrastructure using **Docker**. The project involves setting up a secure, multi-service web stack (WordPress, MariaDB, and Nginx), where each component runs in its own dedicated and isolated container.

The entire infrastructure is built "from scratch" using **Debian** as a base image, ensuring a deep understanding of container isolation, virtual network management, and data persistence.

## 2. Instructions

### Prerequisites
* **Docker** and **Docker Compose** installed.
* The `make` utility.

### Installation and Execution
1.  Clone the repository.
2.  Configure your `/etc/hosts` file on the host machine:
    ```bash
    echo "127.0.0.1 abouclie.42.fr" | sudo tee -a /etc/hosts
    ```
3.  Place your sensitive credentials in the `secrets/` directory and the `srcs/.env` file.
4.  Launch the project using the Makefile:
    ```bash
    make
    ```
    *This command will create the necessary directories, build the custom images, and start the containers in detached mode.*

## 3. Project Design & Technical Choices

### Docker Architecture
The project follows a "micro-services" architecture. Each service (Nginx, MariaDB, WordPress) is strictly isolated. This modularity ensures that a failure in one service does not crash the entire stack and allows for independent maintenance and updates.

### Technical Comparisons

#### Virtual Machines vs Docker
* **Virtual Machines:** Each VM includes a full guest operating system, consuming significant RAM and CPU. They offer strong isolation but are slow to boot.
* **Docker:** Containers share the host OS kernel, making them lightweight, extremely fast to start, and highly efficient in resource usage.

#### Secrets vs Environment Variables
* **Environment Variables:** Ideal for non-sensitive configurations (database names, URLs). However, they remain visible via commands like `docker inspect`.
* **Secrets:** Managed as files mounted in `/run/secrets/`. They are more secure because they are not stored in the image or the environment, significantly reducing the risk of accidental exposure.

#### Docker Network vs Host Network
* **Host Network:** The container shares the host's IP and port space directly. It is fast but offers no network isolation.
* **Docker Network (Bridge):** Creates an isolated virtual network. Services communicate with each other using container names as hostnames, while only required ports (443) are exposed to the outside world.

#### Docker Volumes vs Bind Mounts
* **Bind Mounts:** Directly maps a specific path from the host to the container. It is highly dependent on the host's file structure.
* **Docker Volumes:** Managed by Docker. In this project, we use **Local Bind Mounts** within Docker Volumes to ensure data persistence in `/home/abouclie/data` while benefiting from Docker's volume management logic.

## 4. Resources

### Documentation & References
* [Docker Documentation](https://docs.docker.com/)
* [MariaDB Knowledge Base](https://mariadb.com/kb/en/)
* [WordPress CLI Handbook](https://make.wordpress.org/cli/handbook/)
* [Nginx Beginner's Guide](http://nginx.org/en/docs/beginners_guide.html)

### Use of AI
In accordance with 42's guidelines, Artificial Intelligence (Gemini) was used as a pedagogical collaborator for the following tasks:
* **Shell Script Debugging:** Assistance in resolving race conditions during the MariaDB initialization process.
* **Technical Explanations:** Clarifying the differences between Docker Secrets and standard environment variables.
* **Documentation:** Drafting and refining `USER_DOC.md`, `DEV_DOC.md`, and `README.md` to ensure professional syntax and clarity.

---

*For more detailed information on administration and development, please refer to the `USER_DOC.md` and `DEV_DOC.md` files located in the repository.*

## 5. More informations

### Make sure healthcheck is working

Rename the binary command
```
docker exec -it mariadb mv /usr/bin/mysqladmin /usr/bin/mysqladmin_bak
```

Waiting until 3 attempts failed

```
docker inspect --format='{{json .State.Health}}' mariadb | jq
```
Checking the container

```
docker ps
```
