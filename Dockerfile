FROM golang:1.11-alpine

MAINTAINER Rosa Imantoro <rosaimantoro@gmail.com>

ARG FILEBEAT_VERSION="6.4.1"
ARG LOGSTHOST="logstash:5000"

ENV FILEBEAT_VERSION=${FILEBEAT_VERSION}
ENV LOGSTHOST=${LOGSTHOST}

COPY ./config/filebeat/filebeat.yml /

RUN apk add --update-cache curl bash libc6-compat && \
    rm -rf /var/cache/apk/* && \
    cd / && \
    curl https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -o /filebeat.tar.gz && \
    tar xzvf /filebeat.tar.gz && \
    rm /filebeat.tar.gz && \
    mv filebeat-${FILEBEAT_VERSION}-linux-x86_64 filebeat && \
    cd filebeat && \
    cp /filebeat/filebeat /usr/bin && \
    rm -rf /filebeat/filebeat.yml && \
    cp /filebeat.yml /filebeat/ && \
    ls -ltr /filebeat && \
    chmod +x filebeat && \
    cat /filebeat/filebeat.yml

VOLUME /filebeat/data

CMD [ "filebeat", "-e", "-c", "filebeat.yml" ]