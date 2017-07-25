FROM ubuntu:16.04
MAINTAINER thangmv@vcs-team

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y software-properties-common \
        && add-apt-repository -y cloud-archive:ocata \
        && apt-get update \
        && apt-get install -y python-openstackclient \
	&& apt-get clean

COPY init_services.sh /usr/local/bin/init_services.sh

RUN chmod +x /usr/local/bin/init_services.sh

CMD ["/bin/bash"]

