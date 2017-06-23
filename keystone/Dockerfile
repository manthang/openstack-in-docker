FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="keystone"
ENV HOSTNAME="docker-3"

#Create $service user
RUN useradd --home-dir "/var/lib/$SERVICE" \
        --create-home \
        --system \
        --shell /bin/false \
        $SERVICE

#Create and set ownership of essential dirs
RUN mkdir -p /var/log/$SERVICE \
        && mkdir -p /etc/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/log/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/lib/$SERVICE \
        && chown -R $SERVICE:$SERVICE /etc/$SERVICE

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y software-properties-common \
        && add-apt-repository -y cloud-archive:ocata \
        && apt-get update \
        && apt-get install -y git python-dev python-pip python-pymysql python-openstackclient \
        apache2 libapache2-mod-wsgi libssl-dev libffi-dev

RUN git clone https://github.com/openstack/keystone.git -b stable/ocata \
        && cd keystone \
        && cp -r etc/* /etc/keystone \
        && cp httpd/wsgi-keystone.conf /etc/apache2/sites-available \
        && ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled/ \
        && echo ServerName $HOSTNAME >> /etc/apache2/apache2.conf \
        && pip install --upgrade .

VOLUME ["/var/log/apache2","/var/log/keystone","/etc/keystone/"]

COPY keystone.conf /etc/keystone/keystone.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5000 35357

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
