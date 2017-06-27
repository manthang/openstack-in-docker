FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV HOSTNAME="docker-3"
ENV SERVICE="keystone"

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
        && apt-get install -y git python-pip python-pymysql apache2 libapache2-mod-wsgi libssl-dev libffi-dev

RUN git clone https://github.com/openstack/keystone.git \
        && cd keystone \
        && git checkout tags/11.0.2 -b stable/ocata \
        && cp -r etc/* /etc/keystone \
        && cp httpd/wsgi-keystone.conf /etc/apache2/sites-available \
        && ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled/ \
        && echo ServerName $HOSTNAME >> /etc/apache2/apache2.conf \
        && sed -i 's\Babel>=2.3.4\Babel!=2.4.0,>=2.3.4\g' requirements.txt \
        && pip --no-cache-dir install --upgrade .

VOLUME ["/var/log/apache2","/var/log/keystone","/etc/keystone/credential-keys","/etc/keystone/fernet-keys"]

COPY keystone.conf /etc/keystone/keystone.conf
COPY keystone-paste.ini /etc/keystone/keystone-paste.ini

EXPOSE 5000 35357

CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
