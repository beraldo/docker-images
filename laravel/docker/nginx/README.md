Nginx 1.25
======================

This is an example of a Nginx web server, version 1.25.

# Building the image

In order to build the image, run this command:

```bash
docker build --tag my-nginx:1.25 -f Dockerfile .
```

It will create an image called `my-nginx:1.25`.

# Running a container using the image

In order to run a container using the created image, use this command:

```bash
docker run -it --rm my-nginx:1.25
```

It will run a container with the nginx server. But if you want to access the HTML page from your browser, you need to bind the contaner's 80 port to a local port on your machine.

To do so, run the container passing the `-p` parameter, like so:

```bash
docker run -it -p 8000:80 --rm my-nginx:1.25
```

That command will run the container and bind it's 80 port to the local 8000 port.

Now you can access this URL on your browser:

```
http://localhost:8000
```

You will see the message `YEAH! It works`, as we defined inside the Dockerfile.
