FROM clamav/clamav:stable_base

# Create and configure directory with proper permissions
RUN mkdir -p /etc/clamav && \
    chown clamav:clamav /etc/clamav && \
    chmod 750 /etc/clamav

# Copy config files with correct ownership
COPY --chown=clamav:clamav config/clamd.conf /etc/clamav/
COPY --chown=clamav:clamav config/freshclam.conf /etc/clamav/

# Set config file permissions
RUN chmod 640 /etc/clamav/*.conf

# Essential environment variables
ENV CLAMD_STARTUP_TIMEOUT=600 \
    FRESHCLAM_CHECKS=4

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=300s \
  CMD echo PING | nc 127.0.0.1 3310 | grep -q PONG || exit 1

EXPOSE 3310