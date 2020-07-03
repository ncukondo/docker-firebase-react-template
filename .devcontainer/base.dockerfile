FROM node:13-alpine AS base

# add shell scripts e.g. create-react-app.sh
COPY **/*.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/*.sh
ENV PATH $PATH:/usr/local/bin

RUN mkdir -p /usr/src/app/node_modules
RUN chmod -R 777 /usr/src



FROM base AS base-github

# install git, hub, ssh
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk add openssh git hub bash

# copy gitcofig
COPY ./.devcontainer/.githubconfig ~/



FROM base-github AS base-github-firebase

RUN apk update && \
    npm install -g npm &&\
    npm install -g firebase-tools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
ENTRYPOINT ["/bin/sh"]
