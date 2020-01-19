FROM alpine:3.11.3

ARG TIPPECANOE_VERSION="065cc1d78d662ec21620596e07749c02a941337f"

RUN apk add --no-cache sudo git g++ make libgcc libstdc++ sqlite-libs sqlite-dev zlib-dev sqlite bash \
 && addgroup sudo && adduser -G sudo -D -H tippecanoe && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
 && cd /root \
 && git clone https://github.com/mapbox/tippecanoe.git tippecanoe \
 && cd tippecanoe \
 && git checkout $TIPPECANOE_VERSION \
 && cd /root/tippecanoe \
 && make \
 && make install \
 && cd /root \
 && rm -rf /root/tippecanoe \
 && apk del git g++ make sqlite-dev zlib-dev

USER tippecanoe
WORKDIR /home/tippecanoe