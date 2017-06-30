FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV SERVICE="horizon"
ENV HOSTNAME=$(hostname)

#Create $service user
RUN useradd --home-dir "/var/lib/$SERVICE" \
        --create-home \
        --system \
        --shell /bin/false \
        $SERVICE

#Create and set ownership of essential dirs
RUN mkdir -p /var/log/$SERVICE \
        && mkdir -p /etc/openstack-dashboard \
        && chown -R $SERVICE:$SERVICE /var/log/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/lib/$SERVICE
        
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y git python-pip python-memcache apache2 libapache2-mod-wsgi gettext locales tzdata

RUN git clone https://github.com/openstack/horizon.git
        && cd horizon \
        && git checkout tags/11.0.3 -b stable/ocata \
        && pip --no-cache-dir install --upgrade -c http://git.openstack.org/cgit/openstack/requirements/plain/upper-constraints.txt?h=stable/ocata .

COPY local_settings.py /etc/openstack-dashboard/local_settings.py
COPY openstack-dashboard.conf /etc/apache2/conf-available/openstack-dashboard.conf

RUN cd /horizon \
	&& ln -s /etc/openstack-dashboard/local_settings.py /usr/local/lib/python2.7/dist-packages/openstack_dashboard/local/local_settings.py \
#	 && ln -s /etc/openstack-dashboard/local_settings.py /horizon/openstack_dashboard/local/local_settings.py \
	&& cp manage.py /usr/local/lib/python2.7/dist-packages/openstack_dashboard \ 
	&& cp manage.py /usr/local/lib/python2.7/dist-packages/horizon \
	&& (cd /usr/local/lib/python2.7/dist-packages/openstack_dashboard && ./manage.py compilemessages) \ 	
  && (cd /usr/local/lib/python2.7/dist-packages/horizon && ./manage.py compilemessages) \
#  && ./manage.py collectstatic --noinput \
#  && ./manage.py compress \
  && cp -r openstack_dashboard/conf/* /etc/openstack-dashboard/ \
  && echo ServerName $HOSTNAME >> /etc/apache2/apache2.conf \
  && ln -s /etc/apache2/conf-available/openstack-dashboard.conf /etc/apache2/conf-enabled/ \
  && chown -R horizon: /etc/openstack-dashboard

VOLUME ["/var/log/apache2"]

EXPOSE 80 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
