#
# KeyDB Dockerfile for ARM
#
#
FROM ubuntu:20.04

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r keydb && useradd -r -g keydb keydb

# add gosu for easy step-down from root
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	gosu nobody true
RUN apt-get install -y libcurl4
# Load binaries to image. Much smaller size than building.
ADD ./app/* /usr/local/bin/

RUN \
  cd /usr/local/bin && \
  mkdir -p /etc/keydb

RUN mkdir /data && chown keydb:keydb /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["keydb-server", "/etc/keydb/redis.conf"]

