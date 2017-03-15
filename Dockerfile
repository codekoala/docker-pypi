FROM alpine:3.5
MAINTAINER Josh VanderLinden <codekoala@gmail.com>

RUN apk update && \
    apk add py-pip && \
    pip install --upgrade pip && \
    mkdir -p /srv/pypi

RUN pip install -U passlib pypiserver[cache]==1.2.0

EXPOSE 80
VOLUME ["/srv/pypi"]

COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
