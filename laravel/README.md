Laravel
===============

This is an example of a development docker environment for running Laravel applications.\

It uses docker-compose and custom images for PHP and Nginx.

# Docker Directories and Files

Almost all of the files are Laravel-related. Below are the docker-related files I added:

```
.
├── docker
│   ├── nginx
│   │   ├── Dockerfile
│   │   ├── README.md
│   │   └── conf.d
│   │       └── default.conf
│   └── php
│       ├── Dockerfile
│       ├── README.md
│       ├── index.php
│       ├── php.ini
│       └── xdebug.ini
├── docker-cmd.sh
├── docker-compose.yml
```

In the `docker` directory you will find the Dockerfiles and image related config files.

The `docker-cmd.sh` is the shell script that is executed in the php CMD docker image. It runs laravel related routines and keeps php-fpm running.

THe `docker-compose.yml` is responsible for the orchestration of the containers.

# Building and Running the project

Once the `docker-compose.yml` has all the rules, you just need to run this command to build the images and run the containers:

```bash
docker-compose up
```

After that, you can access the application on the browser, hitting `http://localhost:8000/`.

