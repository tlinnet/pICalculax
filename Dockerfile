# Read: https://hub.docker.com/r/jupyter/scipy-notebook/
# Tags: https://hub.docker.com/r/jupyter/scipy-notebook/tags/
# https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook
# The Dockerfile for pre-setup.
# https://github.com/tlinnet/pICalculax/blob/master/Docker/Dockerfile_local

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
    mkdir bin && \
    mkdir pICalculax_dir

# Copy files into images ${HOME}
COPY LICENSE ${HOME}/pICalculax_dir
COPY README.md ${HOME}/pICalculax_dir
COPY pICalculax.py ${HOME}/pICalculax_dir
COPY Rules.py ${HOME}/pICalculax_dir
COPY Example_Usage.py ${HOME}/pICalculax_dir
# Copy directories
COPY Datasets ${HOME}/pICalculax_dir/Datasets
#COPY mods_db ${HOME}/pICalculax_dir/mods_db

# Copy over bin, add to sh path
COPY bin/pICalculax ${HOME}/bin
COPY bin/py27 ${HOME}/bin
ENV PATH="${HOME}/bin:${PATH}"

# Add to PYTHONPATH, so python can find the pICalculax.py file
ENV PYTHONPATH="${HOME}/pICalculax_dir:${PYTHONPATH}"

### Set root, and make folder writable
USER root
RUN chown -R ${NB_UID}:users ${HOME}/bin
RUN chown -R ${NB_UID}:users ${HOME}/pICalculax_dir
USER ${NB_USER}

# Possible set workdir
# WORKDIR ${HOME}/pICalculax_dir
