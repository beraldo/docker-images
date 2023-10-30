FROM nginx:1.25

# Application root path
ARG app_dir="/app"

WORKDIR ${app_dir}

# Creates the index.html file with the message: YEAH! It works
RUN echo "<h1>YEAH! It works!</h1>" > index.html

EXPOSE 80

COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf
