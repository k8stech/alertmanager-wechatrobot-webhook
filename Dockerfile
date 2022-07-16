FROM --platform=linux/amd64 amd64/alpine:3.12.0
#FROM --platform=linux/amd64 golang:1.17-alpine

# docker pull golang:1.17-alpine@sha256:ad6c114a2c858710c4db54f6c89d0e76f753831f01827252064be0017612fecc

ENV PATH /usr/local/bin:$PATH
ENV LANG C.UTF-8

ENV TZ=Asia/Shanghai

RUN apk update && apk upgrade \
    && apk add ca-certificates\
    && update-ca-certificates \
    && apk --no-cache add openssl wget \
	&& apk add --no-cache bash tzdata curl \
	&& set -ex \
    && mkdir -p /usr/bin \
    && mkdir -p /usr/sbin \
    && mkdir -p /data/wechat-webhook/

ADD bin/wechat-webhook /usr/bin/
ADD start.sh /data/wechat-webhook/

WORKDIR /data/wechat-webhook/
