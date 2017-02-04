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
WORKDIR /
ENV PORT=6881 INDIR=/mnt/in OUTDIR=/mnt/out
EXPOSE $PORT
VOLUME $INDIR $OUTDIR
COPY cmd/start /usr/local/bin/start
ENTRYPOINT ["/usr/local/bin/start"]
