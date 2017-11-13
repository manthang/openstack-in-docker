FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="masakari"

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

RUN apt update \
	&& apt install -y git python-pip python-pymysql python-memcache \
	&& apt clean

RUN git clone https://github.com/openstack/masakari

RUN cd /masakari \
    && git checkout -b stable/ocata \
    && pip install -r requirements.txt . \
    && cp etc/masakari/* /etc/masakari/

COPY masakari.conf /etc/masakari/
COPY bootstrap.sh /usr/local/bin/
COPY start_masakari-api.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/*.sh \
	&& rm -rf /masakari

EXPOSE 15868

USER masakari

CMD ["start_masakari-api.sh"]
