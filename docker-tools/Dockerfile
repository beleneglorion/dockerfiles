FROM  mykiwi/docker

RUN apk add --no-cache git bash coreutils grep  && \
    git clone https://github.com/beleneglorion/git-semver.git && \
    /bin/bash git-semver/install.sh
