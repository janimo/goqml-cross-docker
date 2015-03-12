# Set up an Ubuntu based environment suitable for cross-building go-qml apps for the Ubuntu phone
# Build it and run it with your home dir bindmounted then run the build from your tree
# docker build --rm -t yourimagename .
# docker run -it -v /home/yourname/any/path:/home/developer -v $GOPATH:/home/developer/gopath yourimagename build

FROM ubuntu:14.10

MAINTAINER Jani Monoses <jani@ubuntu.com>

ADD sources.list /etc/apt/

RUN dpkg --add-architecture armhf

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common

RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:jani/golang

RUN apt-get update

RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y golang-go golang-go-linux-arm crossbuild-essential-armhf git mercurial qtdeclarative5-dev:armhf qtbase5-private-dev:armhf qtdeclarative5-private-dev:armhf libqt5opengl5-dev:armhf qtdeclarative5-qtquick2-plugin:armhf

RUN adduser --disabled-password --quiet --gecos Developer developer

USER developer
ENV HOME /home/developer
WORKDIR /home/developer

ENV GOOS linux
ENV GOARCH arm
ENV GOARM 7
ENV GOPATH /home/developer/gopath
ENV CGO_ENABLED 1
ENV PKG_CONFIG_LIBDIR /usr/lib/arm-linux-gnueabihf/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig
ENV CC arm-linux-gnueabihf-gcc
ENV CXX arm-linux-gnueabihf-g++

ENTRYPOINT ["/usr/bin/go"]
