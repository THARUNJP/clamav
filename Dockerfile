FROM clamav/clamav:stable_base

# Create config directory
RUN mkdir -p /etc/clamav && \
    chown clamav:clamav /etc/clamav && \
    chmod 750 /etc/clamav

# Add validated configs
COPY --chown=clamav:clamav config/clamd.conf /etc/clamav/
COPY --chown=clamav:clamav config/freshclam.conf /etc/clamav/
RUN chmod 640 /etc/clamav/*.conf

# Verify config syntax (non-downloading test)
RUN freshclam --config-file=/etc/clamav/freshclam.conf --user=clamav --datadir=/tmp --no-dns

ENV CLAMD_STARTUP_TIMEOUT=600
EXPOSE 3310

HEALTHCHECK --interval=30s --timeout=10s --start-period=300s \
  CMD echo PING | nc 127.0.0.1 3310 | grep -q PONG || exit 1