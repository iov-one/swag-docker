FROM golang:1.13.8-alpine3.11 AS build

RUN apk --no-cache add --update upx

ARG SWAG_VERSION=1.6.5

RUN GO111MODULE=on go get \
  github.com/swaggo/swag/cmd/swag@v${SWAG_VERSION} && \
  mv /go/bin/swag /usr/local/bin

RUN upx --lzma /usr/local/bin/*
  
FROM alpine:3.11

WORKDIR /work

COPY --from=build /usr/local/bin /usr/local/bin


