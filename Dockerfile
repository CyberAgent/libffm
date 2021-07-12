FROM ubuntu:18.04
MAINTAINER Masashi Shibata <contact@c-bata.link>

RUN apt-get update && \
    apt-get install -y build-essential valgrind cmake && \
    rm -rf /var/lib/apt/lists/*


ADD ./Makefile /usr/src/Makefile
ADD ./*.cpp /usr/src/
ADD ./*.h /usr/src/

WORKDIR /usr/src
RUN make USEOMP=OFF

VOLUME /usr/src/data
CMD ["bash"]
