# docker-yi-hack

[![Docker Stars](https://img.shields.io/docker/stars/borodiliz/yi-hack.svg)](https://hub.docker.com/r/borodiliz/yi-hack/)
[![Docker Pulls](https://img.shields.io/docker/pulls/borodiliz/yi-hack.svg)](https://hub.docker.com/r/borodiliz/yi-hack/)

The repository is maintained at <https://github.com/borodiliz/docker-yi-hack/>

**WORK IN PROGRESS**

This docker image provides a development environment for the [Hack for YI cameras ](https://github.com/roleoroleo/yi-hack-MStar) which is maintained by @roleoroleo. All the necessary tools to build the project are provided by this docker image.
    
## Usage

1. Prepare you .ssh directory. You should provide the .ssh directory that will be used in the container. As an example, you should add your public ssh key to your authorized_keys:

    cat ~/.ssh/id_rsa.pub >>  ~/.ssh/authorized_keys

2. Clone [roleoroleo/yi-hack-MStar](https://github.com/roleoroleo/yi-hack-MStar) 

    git clone https://github.com/roleoroleo/yi-hack-MStar.git

3. Run docker container (set ssh port and paths to your needs)

    docker run -d \
    -v ~/yi-hack-MStar:/yi-hack-src \  
    -v ~/.ssh:/root/.ssh \
    -p 2225:22 \ 
    borodiliz/yi-hack:latest 
    
4. Connect to docker container using SSH

    ssh root@localhost -p 2225
    
4. Start coding!

    cd /yi-hack-src # And start coding!

## Build image yourself (instead of using dockerhub)

1. Clone this repository

    git clone https://github.com/borodiliz/docker-yi-hack

2. Build and tag a new docker image
    
    docker image build -t my-yi-hack:latest .

3. Run a new container

    docker run -d \
    -v ~/yi-hack-MStar:/yi-hack-src \  
    -v ~/.ssh:/root/.ssh \
    -p 2225:22 \ 
    my-yi-hack:latest 
