# Read: https://hub.docker.com/r/jupyter/scipy-notebook/
# Tags: https://hub.docker.com/r/jupyter/scipy-notebook/tags/
# https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook
# The Dockerfile for pre-setup.
# https://github.com/tlinnet/pICalculax/blob/docker/Docker/Dockerfile_local

FROM tlinnet/picalculax:01_setup

LABEL maintainer="Troels Schwarz-Linnet <tlinnet@gmail.com>"

# Set variables    
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

# jupyter notebook password remove
RUN echo "" && \
    mkdir -p $HOME/.jupyter && \
    cd $HOME/.jupyter && \
    echo "c.NotebookApp.token = u''" > jupyter_notebook_config.py

# Make directory
RUN cd ${HOME} && \
    mkdir pICalculax

# Copy files into images ${HOME}
COPY LICENSE ${HOME}/pICalculax
COPY README.md ${HOME}/pICalculax
COPY pICalculax.py ${HOME}/pICalculax
COPY Rules.py ${HOME}/pICalculax
COPY Example_Usage.py ${HOME}/pICalculax
# Copy directories
COPY Datasets ${HOME}/pICalculax/Datasets
#COPY mods_db ${HOME}/pICalculax/mods_db

# Copy over bin, add to sh path
COPY bin/pICalculax ${HOME}/bin
ENV PATH="${HOME}/bin:${PATH}"

### Set root, and make folder writable
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}