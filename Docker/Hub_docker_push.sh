# To upload images to docker bub, source the file
export DOCKER_ID_USER=$USER

# Push to docker
docker login

# Image with RDKit
#docker tag $USER/picalculax:01_setup $DOCKER_ID_USER/picalculax:01_setup
docker push $DOCKER_ID_USER/picalculax:01_setup

# Image with picalculax
#docker tag $USER/picalculax:02_picalculax $DOCKER_ID_USER/picalculax:02_picalculax
docker push $DOCKER_ID_USER/picalculax:02_picalculax