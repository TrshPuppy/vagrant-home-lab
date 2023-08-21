# Golang image version. The '-bullseye' at the end indicates the Debian release.
#... Our image: https://github.com/docker-library/golang/blob/bba543aacac120bf09b371bd1b41496f3d2ea89d/1.20/bullseye/Dockerfile
FROM golang:1.20.6-bullseye
ENV DEBIAN_FRONTEND=noninteractive

#------ Our Image starts us in GOPATH as the WORKDIR (I think), so let's fix that:
WORKDIR /home

#------ Maintenance:
RUN apt update \
    && apt upgrade -y

#------ Install some tools:
RUN apt install -y \
    sudo \
    vim \
    git \
    make

#------ User things:
#
# Some friendly advice from: https://github.com/allaboutapps/go-starter/blob/master/Dockerfile:
#
# linux permissions / vscode support: Add user to avoid linux file permission issues
# Detail: Inside the container, any mounted files/folders will have the exact same permissions
# as outside the container - including the owner user ID (UID) and group ID (GID).
# Because of this, your container user will either need to have the same UID or be in a group with the same GID.
# The actual name of the user / group does not matter. The first user on a machine typically gets a UID of 1000,
# so most containers use this as the ID of the user to try to avoid this problem.
# 2020-04: docker-compose does not support passing id -u / id -g as part of its config, therefore we assume uid 1000
# https://code.visualstudio.com/docs/remote/containers-advanced#_adding-a-nonroot-user-to-your-dev-container
# https://code.visualstudio.com/docs/remote/containers-advanced#_creating-a-nonroot-user
ARG USER=trshpuppy
ARG USER_UID=1000
ARG USER_GID=1000

RUN useradd -m -s /bin/bash ${USER} \
    && echo "$USER ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER} \
    && usermod -a -G sudo ${USER} \
    && chmod 0440 /etc/sudoers.d/${USER} 

#------ Golang Things:
# RUN mkdir -p /$GOPATH/pkg && chown -R $USER /$GOPATH
#
# Some more friendly advice (same source):
#
# $GOBIN is where our own compiled binaries will live and other go.mod / VSCode binaries will be installed.
# It should always come AFTER our other $PATH segments and should be earliest targeted in stage "builder",
# as /app/bin will the shadowed by a volume mount via docker-compose!
# E.g. "which golangci-lint" should report "/go/bin" not "/app/bin" (where VSCode will place it).
# https://github.com/go-modules-by-example/index/blob/master/010_tools/README.md#walk-through

WORKDIR /home/${USER}
# WORKDIR reference: https://docs.docker.com/engine/reference/builder/#workdir
#
#... Go env should look like:
#...... $GOPATH = ~/trshpuppy/repos/<current go project>   <--- This is a wrapper folder for ea. Go project in /repos
#...... $GOROOT = ~/trshpuppy/go/go/bin  
#             
RUN mkdir repos \
    && mkdir go

RUN chown -R $USER_UID:$USER_GID repos \
    && chmod -R 755 repos
RUN chown -R $USER_UID:$USER_GID go \
    && chmod -R 755 go

# The base image has golang installed in /usr/local/go
#... We want to move that...
#...... Change ownership to our user and our user's group:
RUN chown -R $USER_UID:$USER_GID /usr/local/go \
    #...... Change permissions:
    && chmod -R 755 /usr/local/go \
    #...... Move that biznath:
    && mv /usr/local/go /home/$USER/go/go

# Set our Go env variables:
ENV GOROOT /home/${USER}/go/go
ENV GOPATH /home/${USER}/repos
#ENV PATH $PATH:$GOROOT

# Update user's profile (probably overkill):
RUN echo "GOPATH=/home/$USER/repos" >> /home/${USER}/.profile \
    && echo "GOROOT=/home/$USER/go/go" >> /home/${USER}/.profile \
    && echo "PATH=\$PATH:\$GOROOT/bin" >> /home/${USER}/.profile


#...... Add some files/ config files:
COPY configs/.vimrc /home/${USER}
COPY configs/.gitconfig /home/${USER}

EXPOSE 8080
# Enter the Dragon:
ENTRYPOINT ["/bin/bash"]