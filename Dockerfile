FROM postgres:9.6.5-alpine

ENV POSTGIS_VERSION 2.4.0

RUN ash -c 'echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories' \
    && apk update \
    && apk add --no-cache --virtual .fetch-deps \
  			ca-certificates \
  			openssl \
  			tar \
    && apk add --no-cache --virtual .build-deps \
  	     		bison \
  			coreutils \
  			flex \
  			gcc \
  			libc-dev \
  			libedit-dev \
  			libxml2-dev \
  			libxslt-dev \
  			make \
  			openssl-dev \
  			perl \
  			util-linux-dev \
  			zlib-dev \
    && apk add --no-cache proj4-dev@testing \
       	     	  geos-dev@testing \
  			        gdal-dev@testing \
    && wget http://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz \
    && tar xvzf postgis-${POSTGIS_VERSION}.tar.gz \
    && rm postgis-${POSTGIS_VERSION}.tar.gz \
    && cd postgis-${POSTGIS_VERSION} \
    && make \
    && make install \
    && cd ../ \
    && rm -r postgis-${POSTGIS_VERSION} \
    && apk del .fetch-deps .build-deps \
    && find /usr/local -name '*.a' -delete

RUN mkdir -p /usr/share/data

VOLUME ["/usr/share/data"]

EXPOSE 5432

CMD ["postgres"]
