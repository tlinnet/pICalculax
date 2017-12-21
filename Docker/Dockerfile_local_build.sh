# To build this image, source the file

# Build user setup
docker build -t $USER/picalculax:01_setup -f Dockerfile_local .
alias pi='docker run -ti --rm -p 8888:8888 -v "$PWD":/home/jovyan/work --name picalculax $USER/picalculax:01_setup'
alias pie='docker exec -it picalculax'