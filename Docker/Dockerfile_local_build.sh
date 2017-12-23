# To build this image, source the file

# Build user setup
docker build -t $USER/picalculax:01_setup -f Dockerfile_local .
# Start Jupyter Notebook
alias pi='docker run -ti --rm -p 8888:8888 -v "$PWD":/home/jovyan/work --name picalculax $USER/picalculax:01_setup'
#alias pi='docker run -ti --rm -p 8888:8888 -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/jovyan/work --name picalculax $USER/picalculax:01_setup'

# Start in bash
alias pib='pi bash'

# Execute in running image
alias pie='docker exec -it picalculax'
