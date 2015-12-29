# This builds an firmware image for proxmark3 from the latest git HEAD.
FROM ubuntu:trusty
MAINTAINER Chrisfu <chrisfu@gmail.com>

# Update image
RUN apt-get -q update &&\
    apt-get -qy --force-yes dist-upgrade

# Install proxmark3 build dependancies
RUN apt-get install -qy --force-yes\
    git\
    gcc\
    build-essential\
    lsb\ 
    libpthread-stubs0-dev\
    libreadline-dev\
    libreadline6\
    libusb-dev\
    perl\
    wget

# Create volume mount point
RUN mkdir /proxmark3 /packages

# Mount volume
VOLUME /packages

# Pull and unpack latest devkitPro ARM toolchain
RUN wget http://skylink.dl.sourceforge.net/project/devkitpro/devkitARM/devkitARM_r45/devkitARM_r45-x86_64-linux.tar.bz2 -O - |\
    tar xfvj - -C /proxmark3

# Set build environment variables
ENV DEVKITPRO /proxmark3
ENV DEVKITARM "$DEVKITPRO/devkitARM"
ENV PATH "${PATH}:${DEVKITARM}/bin"

# Clean up archived packages to trim image size
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /tmp/*

# Import build script and set correct permissions
ADD ./build.sh /build.sh
RUN chmod u+x /build.sh

# The build script gets executed by default when the container is started, or created with the `docker run` command
ENTRYPOINT ["/build.sh"]
