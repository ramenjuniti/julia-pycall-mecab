FROM julia:latest

LABEL maintainer "ramenjuniti <ramenjuniti@gmail.com>"

RUN apt-get update \
    && apt-get install -y mecab \
    && apt-get install -y libmecab-dev \
    && apt-get install -y mecab-ipadic-utf8\
    && apt-get install -y git\
    && apt-get install -y make\
    && apt-get install -y curl\
    && apt-get install -y xz-utils\
    && apt-get install -y file\
    && apt-get install -y sudo\
    && apt-get install -y wget

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git\
    && cd mecab-ipadic-neologd\
    && bin/install-mecab-ipadic-neologd -n -y\
    && cd ..\
    && rm -r mecab-ipadic-neologd\
    && echo "export DIC=$(echo `mecab-config --dicdir`'/mecab-ipadic-neologd')" >> $HOME/.bashrc

ENV DIC="$DIC"

RUN julia -e 'using Pkg; Pkg.add("PyCall")'
RUN julia -e 'ENV["PYTHON"]="/root/.julia/conda/3/bin/python"'
ENV PATH="/root/.julia/conda/3/bin:$PATH:${PATH}"

RUN pip install mecab-python3