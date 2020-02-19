FROM  mykiwi/docker
COPY ssh-config /root/.ssh/config
RUN \
    chmod u=r,go= /root/.ssh/config && \
    apk --no-cache add rsync \
    openssh-client \
    git \
    bash \
    coreutils \
    gettext \
    grep \
    curl \
    perl \
    && git clone https://github.com/beleneglorion/git-semver.git && \
    /bin/bash git-semver/install.sh
