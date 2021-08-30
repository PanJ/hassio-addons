ARG GOLANG_VERSION=1.17.0
ARG ALPINE_VERSION=3.14
ARG UPSTREAM_RELEASE_TAG=2021.8.6

FROM golang:${GOLANG_VERSION}-alpine${ALPINE_VERSION} as gobuild
ARG GOLANG_VERSION
ARG ALPINE_VERSION
ARG UPSTREAM_RELEASE_TAG

WORKDIR /tmp

RUN apk add --no-cache git gcc build-base alpine-sdk curl tar && \
    mkdir release && \
    curl -L "https://github.com/cloudflare/cloudflared/archive/refs/tags/${UPSTREAM_RELEASE_TAG}.tar.gz" | tar xvz --strip 1 -C ./release

WORKDIR /tmp/release/cmd/cloudflared

RUN go build ./

FROM alpine:${ALPINE_VERSION}

ARG GOLANG_VERSION
ARG ALPINE_VERSION

RUN apk add --no-cache ca-certificates bind-tools libcap; \
  rm -rf /var/cache/apk/*; \
  mkdir /etc/cloudflared;

COPY --from=gobuild /tmp/release/cmd/cloudflared/cloudflared /usr/local/bin/cloudflared

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]