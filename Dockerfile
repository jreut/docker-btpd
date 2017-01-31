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
COPY cmd/start /usr/local/bin/start
EXPOSE 6881
RUN mkdir -p /var/btpd/{in,out}
VOLUME ["/var/btpd/in", "/var/btpd/out"]
ENTRYPOINT ["/usr/local/bin/start"]
