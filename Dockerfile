FROM alpine
RUN apk add --no-cache \
  build-base \
  curl \
  inotify-tools \
  libressl-dev
RUN curl -L -O https://github.com/downloads/btpd/btpd/btpd-0.16.tar.gz && \
  tar -xf btpd-0.16.tar.gz
WORKDIR btpd-0.16
RUN ./configure && make && make install
EXPOSE 6881
RUN mkdir -p /var/btpd/{in,out}
VOLUME ["/var/btpd/in", "/var/btpd/out"]
COPY cmd/start /usr/local/bin/start
ENTRYPOINT ["/usr/local/bin/start"]
