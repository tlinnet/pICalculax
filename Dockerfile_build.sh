# To build this image, source the file

# Build user setup
docker build -t $USER/picalculax:02_picalculax -f Dockerfile .
# Start Jupyter Notebook
alias pi='docker run -ti --rm -p 8888:8888 -v "$PWD":/home/jovyan/work --name picalculax $USER/picalculax:02_picalculax'
# Start in bash
alias pib='pi bash'
# Execute in running image
alias pie='docker exec -it picalculax'