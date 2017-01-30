FROM alpine
RUN apk add --no-cache \
  build-base \
  curl \
  libressl-dev
RUN curl -L -O https://github.com/downloads/btpd/btpd/btpd-0.16.tar.gz && \
  tar -xf btpd-0.16.tar.gz
WORKDIR btpd-0.16
RUN ./configure && make && make install
COPY cmd/start /usr/local/bin/start
ENTRYPOINT ["/usr/local/bin/start"]
