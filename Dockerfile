FROM ubuntu:16.04
MAINTAINER Jason Kingsbury <jason@relva.co.uk>
LABEL com.image.version="4.0.0" com.image.description="flask, uwsgi and nginx application stack"

EXPOSE 80
WORKDIR /app

RUN apt-get -y update && apt-get -y install python-setuptools python-pip nginx && pip install uwsgi flask flask-restful && rm -rf /root/.cache/pip/

ADD init /system/init
ADD uwsgi.conf /etc/uwsgi/
ADD nginx.conf /etc/nginx/

ONBUILD ADD . /home/app/
ONBUILD RUN /system/init --install
ONBUILD CMD ["/system/init", "--execute"]

CMD ["/system/init", "--install", "--execute"]
