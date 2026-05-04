# 1) choose base container
# generally use the most recent tag

# base notebook, contains Jupyter and relevant tools
# See https://github.com/ucsd-ets/datahub-docker-stack/wiki/Stable-Tag
# for a list of the most current containers we maintain

ARG BASE_CONTAINER=ghcr.io/ucsd-ets/scipy-ml-notebook:2025.2-stable

# Pin to x86-64 so the image never resolves to an arm64 variant
FROM --platform=linux/amd64 $BASE_CONTAINER

LABEL maintainer="UC San Diego ITS/ETS <ets-consult@ucsd.edu>"

# 2) change to root to install packages
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
  python3.10 \
  python3-dev \
  python3-distutils \
  python3-tk \
  libfuse2 \
  graphviz \
  libgraphviz-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3) install packages using notebook user
USER jovyan

# RUN conda install -y scikit-learn

# RUN pip install --no-cache-dir networkx scipy

# Override command to disable running jupyter notebook at launch
# CMD ["/bin/bash"]
