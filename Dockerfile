FROM caliahub/jenkins-agent:4.3

MAINTAINER Calia "cnboycalia@gmail.com"

ENV NODE_VERSION=10.16.1

RUN apk add --no-cache \
        libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        binutils-gold \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python \
    && wget "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.xz" \
    && tar -xf "node-v${NODE_VERSION}.tar.xz" \
    && cd "node-v${NODE_VERSION}" \
    && ./configure \
    && make \
    && make install \
    && apk del .build-deps \
    && cd .. \
    && rm -Rf "node-v${NODE_VERSION}" \
    && rm "node-v${NODE_VERSION}.tar.xz" 

VOLUME /root/.npm
