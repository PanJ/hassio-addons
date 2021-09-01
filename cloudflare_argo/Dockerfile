ARG ALPINE_VERSION=3.14
ARG BASHIO_VERSION=0.13.1

FROM alpine:${ALPINE_VERSION}

ARG GOLANG_VERSION
ARG ALPINE_VERSION
ARG BUILD_ARCH
ARG BASHIO_VERSION

RUN \
    set -x \
    && apk add --no-cache \
        bash \
        bind-tools \
        ca-certificates \
        curl \
        jq

RUN mkdir -p /usr/src/bashio \
  && curl -L -f -s "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" \
      | tar -xzf - --strip 1 -C /usr/src/bashio \
  && mv /usr/src/bashio/lib /usr/lib/bashio \
  && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
  && rm -rf /usr/src/bashio

RUN CVERSION="latest/download" \
  ARCH="${BUILD_ARCH}" \
  && if [[ "${BUILD_ARCH}" = "aarch64" ]]; then ARCH="arm64"; fi \
  && if [[ "${BUILD_ARCH}" = "amd64" ]]; then ARCH="amd64"; fi \
  && if [[ "${BUILD_ARCH}" = "armhf" ]]; then ARCH="arm"; fi \
  && if [[ "${BUILD_ARCH}" = "armv7" ]]; then ARCH="arm"; fi \
  && if [[ "${BUILD_ARCH}" = "i386" ]]; then ARCH="386"; fi \
  && apk add --no-cache libc6-compat yq \
  && wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/$CVERSION/cloudflared-linux-$ARCH && chmod a+x /usr/local/bin/cloudflared

RUN cloudflared -v

WORKDIR /data

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
