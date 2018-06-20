FROM ubuntu:18.04
MAINTAINER Jason Kingsbury <jason@relva.co.uk>
LABEL com.image.version="5.0.0" com.image.description="flask, uwsgi and nginx application stack"

EXPOSE 80
WORKDIR /app
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 UWSGI_ENTRYPOINT=api UWSGI_APPLICATION=app

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.4.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /
ENTRYPOINT ["/init"]

COPY bin /bin

RUN chmod a+rx /bin/pkg-installer && \
    apt-get -y update && \
    apt-get -qq -y install python-setuptools python-pip && \
    apt-get -qq -y install nginx && \
    pip install --no-cache-dir uwsgi flask flask-restful && \
    rm -rf /var/lib/apt/lists/*

COPY etc /etc

ONBUILD COPY . /app/
ONBUILD RUN /bin/pkg-installer && rm /etc/cont-init.d/02-pkg-installer

