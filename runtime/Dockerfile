FROM ubuntu:16.04
MAINTAINER Jason Kingsbury <jason@relva.co.uk>
LABEL com.image.version="3.0.0" com.image.description="Python, uWSGI and NGINX stack"

EXPOSE 80

RUN apt-get -y update && apt-get -y install python-setuptools python-pip nginx && pip install uwsgi flask flask-restful && rm -rf /root/.cache/pip/ && mkdir /app

ADD ./system/init /system/init
ADD ./uwsgi.conf /etc/uwsgi/
ADD ./nginx.conf /etc/nginx/

WORKDIR /app


CMD ["/system/init", "--install", "--execute"]
