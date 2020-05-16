FROM balenalib/rpi-raspbian:buster

RUN echo "deb http://archive.raspbian.org/raspbian testing main" \
    > /etc/apt/sources.list \
  && apt-get update && apt-get install -y \
    build-essential/testing \
    nim/testing \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*
