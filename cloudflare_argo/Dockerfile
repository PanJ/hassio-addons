ARG GOLANG_VERSION=1.17
ARG ALPINE_VERSION=3.14
ARG BUILD_FROM=alpine:${ALPINE_VERSION}

FROM golang:${GOLANG_VERSION}-alpine${ALPINE_VERSION} as gobuild
ARG GOLANG_VERSION
ARG ALPINE_VERSION

RUN apk add --no-cache git gcc build-base alpine-sdk; \
  mkdir /tmp/cloudflare; \
  cd /tmp/cloudflare; \
  git clone https://github.com/cloudflare/cloudflared.git

WORKDIR /tmp/cloudflare/cloudflared/cmd/cloudflared

RUN go build ./

FROM $BUILD_FROM

RUN apk add --no-cache ca-certificates bind-tools libcap; \
  rm -rf /var/cache/apk/*; \
  mkdir /etc/cloudflared;

COPY --from=gobuild /tmp/cloudflare/cloudflared/cmd/cloudflared/cloudflared /usr/local/bin/cloudflared

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]