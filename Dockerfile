FROM clamav/clamav:stable_base

# Create config directory with proper permissions
RUN mkdir -p /etc/clamav && \
    chown clamav:clamav /etc/clamav && \
    chmod 750 /etc/clamav

# Copy verified config files
COPY --chown=clamav:clamav config/clamd.conf /etc/clamav/
COPY --chown=clamav:clamav config/freshclam.conf /etc/clamav/
RUN chmod 640 /etc/clamav/*.conf

# Verify configs during build (catches errors early)
RUN freshclam --list-mirrors --config-file=/etc/clamav/freshclam.conf

ENV CLAMD_STARTUP_TIMEOUT=600
EXPOSE 3310

HEALTHCHECK --interval=30s --timeout=10s --start-period=300s \
  CMD echo PING | nc 127.0.0.1 3310 | grep -q PONG || exit 1