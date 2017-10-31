FROM centos
MAINTAINER Matthew Benstead

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum install -y python-pip python-passlib && pip install -U pypiserver && mkdir -p /srv/pypi

EXPOSE 80
VOLUME ["/srv/pypi"]

COPY srv/pypi/ /srv/pypi/
COPY htpasswd /srv/pypi/.htpasswd
COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
