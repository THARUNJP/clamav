FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y clamav clamav-daemon && \
    rm -rf /var/lib/apt/lists/*

RUN freshclam

RUN mkdir -p /var/run/clamav && \
    chown clamav:clamav /var/run/clamav

EXPOSE 3310

WORKDIR /app

CMD ["clamd", "--foreground", "--config-file=/etc/clamav/clamd.conf"]
