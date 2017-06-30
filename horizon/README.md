# 1. BUILD
docker build -t controller:4000/horizon .

# 2. RUN
docker run -d --name horizon --network=host -v /var/log/apache2:/var/log/apache2 -v /var/lib/openstack-dashboard:/var/lib/openstack-dashboard controller:4000/horizon
