FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="nova"

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
        && apt-get install -y git python-pip python-pymysql python-memcache libssl-dev libffi-dev \
          iptables sudo

RUN git clone https://github.com/openstack/nova.git \
	&& cd nova \
	&& git checkout tags/15.0.6 -b stable/ocata \
        && cp -R etc/nova/* /etc/nova \
	&& sed -i 's\Babel>=2.3.4\Babel!=2.4.0,>=2.3.4\g' requirements.txt \
        && pip --no-cache-dir install --upgrade .

VOLUME ["/var/log/nova","/var/lib/nova"]

COPY nova.conf /etc/nova/nova.conf
COPY nova_sudoers /etc/sudoers.d/nova

CMD ["/usr/bin/python", "/usr/local/bin/nova-scheduler"]
