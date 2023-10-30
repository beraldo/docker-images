PHP-FPM 8.2
======================

This is an example of a development docker environment for running PHP 8.2 applications.

# Building the image

In order to build the image, run this command:

```bash
docker build --tag my-php-app:8.2 -f Dockerfile .
```

It will create an image called `my-php-app:8.2`.

# Running a container using the image

In order to run a container using the created image, use this command:

```bash
docker run -it --rm my-php-app:8.2 bash
```

It will run `bash` in the container. It's similar to run a terminal through SSH in a VM.

You can run the `index.php` example script:

```bash
docker run -it --rm my-php-app:8.2 php index.php
```

# Using Xdebug

The image is configured to use Xdebug. It's already installed and enabled by default.

You can configure your IDE to use port 9003. If you are using Visual Studio Code, you can configure you `launch.json` file like this:

```json
"configurations": [
    {
        "name": "Listen for Xdebug",
        "type": "php",
        "request": "launch",
        "port": 9003,
        "pathMappings": {
            "/app": "${workspaceFolder}/php/php-8.2"
        }
    },
    ...
```

After that, if you create a breakpoint in the `index.php` script and run the `php index.php` again (inside the container), the executation will pause in the breakpint.

## Xdebug logs

The `xdebug.ini` file is configured to store the logs in the file `xdebug.log`. You can check this file for debug logs.
