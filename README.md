1. Build images

- On Controller01, run these commands to build and then push the images to Docker private registry.

./build_images.sh

./push_images.sh

2. Run containers

- On Controller01, run this command to initialize the essential data and configurations of OpenStack environment.

./bootstrap_and_run_services.sh

- On the other Controller nodes, run these commands to pull latest images on the registry and then run containers of OpenStack services from them.

./pull_images.sh

./run_services.sh
