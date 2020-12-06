FROM ubuntu:focal

ARG JAVA_VERSION=zulu15.28.51-ca-jre15.0.1-linux_aarch64
ARG JAVA_ARCHIVE=$JAVA_VERSION.tar.gz

LABEL maintainer="Grégory Van den Borre vandenborre.gregory@hotmail.fr"

RUN mkdir /usr/lib/jvm
RUN apt update && apt install -y curl
RUN curl https://cdn.azul.com/zulu-embedded/bin/$JAVA_ARCHIVE --output $JAVA_ARCHIVE
RUN tar xvzf $JAVA_ARCHIVE -C /usr/lib/jvm/ && /usr/lib/jvm/$JAVA_VERSION/bin/java -version

RUN rm $JAVA_ARCHIVE
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/$JAVA_VERSION/bin/java 1101 && update-alternatives --config java
RUN apt purge -y curl libcurl4 libnghttp2-14 librtmp1 libssh-4
RUN java -version
