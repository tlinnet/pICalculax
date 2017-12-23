# To build this image, source the file

# Build user setup
docker build -t $USER/picalculax:01_setup_py36 -f Dockerfile_local_py36 .
# Start Jupyter Notebook
alias pi_py36='docker run -ti --rm -p 8888:8888 -v "$PWD":/home/jovyan/work --name picalculax_py36 $USER/picalculax:01_setup_py36'
# Start in bash
alias pib_py36='pi_py36 bash'
# Execute in running image
alias pie_py36='docker exec -it picalculax'
