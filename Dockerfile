From ubuntu:16.04
# refer
# https://gist.github.com/remarkablemark/aacf14c29b3f01d6900d13137b21db3a

ENV TZ 'Asia/Shanghai'

COPY . /blog
WORKDIR /blog

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# nvm environment variables
RUN mkdir -p /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.10.0


RUN apt update -y && \
    apt-get install -y wget curl && \
    apt-get -y autoclean

# install hugo
RUN wget -O /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.54.0/hugo_0.54.0_Linux-64bit.deb && \
    dpkg -i /tmp/hugo.deb && \
    rm -rf /tmp/hugo.deb

# install nvm
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# install node and npm
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# install gulp
RUN npm install -g npm@6.9.0 gulp@3.9.1

ENTRYPOINT gulp serve