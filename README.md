# Inception - 42 Project

*This project has been created as part of the 42 curriculum by abouclie.*

## 1. Description
Le projet **Inception** est une étape clé du cursus DevOps de 42. Son objectif est d'élargir les connaissances en administration système en gérant une infrastructure complète via **Docker**. Le projet consiste à mettre en place une pile web sécurisée (WordPress, MariaDB et Nginx), où chaque service s'exécute dans son propre conteneur dédié.

Toute l'infrastructure est construite "from scratch" en utilisant **Debian** comme image de base, garantissant une compréhension profonde de l'isolation des conteneurs, de la gestion des réseaux virtuels et de la persistance des données.

## 2. Instructions

### Prérequis
* Un environnement Linux (VM ou natif).
* **Docker** et **Docker Compose** installés.
* L'utilitaire `make`.

### Installation et Exécution
1.  Clonez le dépôt.
2.  Configurez votre fichier `/etc/hosts` sur la machine hôte :
    ```bash
    echo "127.0.0.1 abouclie.42.fr" | sudo tee -a /etc/hosts
    ```
3.  Placez vos identifiants sensibles dans le dossier `secrets/` et le fichier `srcs/.env`.
4.  Lancez le projet à l'aide du Makefile :
    ```bash
    make
    ```
    *Cette commande créera les répertoires nécessaires, construira les images et démarrera les conteneurs en mode détaché.*

## 3. Conception du Projet et Choix Techniques

### Architecture Docker
Le projet repose sur une architecture de "micro-services". Chaque service (Nginx, MariaDB, WordPress) est isolé. Cette modularité garantit qu'une défaillance dans un service ne fait pas s'effondrer toute la pile et permet une maintenance indépendante.

### Comparaisons Techniques

#### Machines Virtuelles vs Docker
* **Machines Virtuelles :** Chaque VM inclut un système d'exploitation complet, consommant beaucoup de RAM et de CPU. Elles offrent une isolation forte mais sont lentes à démarrer.
* **Docker :** Les conteneurs partagent le noyau de l'OS hôte, ce qui les rend légers, extrêmement rapides à démarrer et efficaces en ressources.

#### Secrets vs Variables d'Environnement
* **Variables d'Environnement :** Idéales pour les configurations non sensibles (noms de base de données, URLs). Cependant, elles peuvent être visibles via `docker inspect`.
* **Secrets :** Gérés comme des fichiers montés dans `/run/secrets/`. Ils sont plus sécurisés car ils ne sont pas stockés dans l'image ni dans l'environnement, réduisant les risques d'exposition accidentelle.

#### Docker Network vs Host Network
* **Host Network :** Le conteneur partage directement l'IP et les ports de l'hôte. C'est rapide mais n'offre aucune isolation.
* **Docker Network (Bridge) :** Crée un réseau virtuel isolé. Les services communiquent entre eux via leurs noms de conteneurs, tandis que seuls les ports nécessaires (443) sont exposés à l'extérieur.

#### Docker Volumes vs Bind Mounts
* **Bind Mounts :** Lie un chemin spécifique de l'hôte au conteneur. Très dépendant de la structure de fichiers de l'hôte.
* **Docker Volumes :** Gérés par Docker. Dans ce projet, nous utilisons des **Local Bind Mounts** au sein de volumes Docker pour garantir la persistance dans `/home/abouclie/data` tout en bénéficiant de la gestion des volumes Docker.

## 4. Ressources

### Documentation et Références
* [Docker Documentation](https://docs.docker.com/)
* [MariaDB Knowledge Base](https://mariadb.com/kb/en/)
* [WordPress CLI Handbook](https://make.wordpress.org/cli/handbook/)
* [Nginx Beginner's Guide](http://nginx.org/en/docs/beginners_guide.html)

### Utilisation de l'IA
Conformément aux directives de 42, l'Intelligence Artificielle (Gemini) a été utilisée comme collaborateur pédagogique pour les tâches suivantes :
* **Débogage de scripts Shell :** Aide à la résolution des conditions de concurrence (race conditions) lors de l'initialisation de MariaDB.
* **Explications Techniques :** Clarification des différences entre les Secrets Docker et les variables d'environnement.
* **Documentation :** Rédaction et correction de `USER_DOC.md` et `README.md` pour garantir une syntaxe professionnelle.
* **Optimisation du Makefile :** Amélioration de la règle `fclean` avec des filtres spécifiques.

---

*Pour plus d'informations sur l'administration, veuillez vous référer au fichier `USER_DOC.md` situé dans le dépôt.*
