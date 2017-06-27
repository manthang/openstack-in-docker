FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="glance"

#Create $service user
RUN useradd --home-dir "/var/lib/$SERVICE" \
        --create-home \
        --system \
        --shell /bin/false \
        $SERVICE

#Create and set ownership of essential dirs
RUN mkdir -p /var/log/$SERVICE \
        && mkdir -p /etc/$SERVICE \
        && mkdir -p /var/lib/$SERVICE/{images,image-cache,scrubber}
        && chown -R $SERVICE:$SERVICE /var/log/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/lib/$SERVICE \
        && chown -R $SERVICE:$SERVICE /etc/$SERVICE

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y git python-pip python-pymysql python-memcache libssl-dev libffi-dev

RUN git clone https://github.com/openstack/glance.git \
	      && cd glance \
	      && git checkout tags/14.0.0 -b stable/ocata \
        && cp -R etc/* /etc/glance \     
        && pip install -U .

VOLUME ["/var/log/glance", "/var/lib/glance/images"]

COPY glance-api.conf /etc/glance/glance-api.conf

EXPOSE 9292

CMD ["/usr/bin/python", "/usr/local/bin/glance-api"]
