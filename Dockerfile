FROM clamav/clamav:stable_base

# Create config directory
RUN mkdir -p /etc/clamav

# Copy custom configurations
COPY config/clamd.conf /etc/clamav/clamd.conf
COPY config/freshclam.conf /etc/clamav/freshclam.conf

# Set environment variables
ENV CLAMAV_NO_FRESHCLAMD=false \
    CLAMAV_NO_CLAMD=false \
    CLAMAV_NO_MILTERD=true \
    CLAMD_STARTUP_TIMEOUT=600 \
    FRESHCLAM_CHECKS=4 \
    CLAMD_CONCURRENT_RELOAD=no \
    FRESHCLAM_TESTDATABASES=no

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=300s \
  CMD echo PING | nc 127.0.0.1 3310 | grep -q PONG || exit 1

EXPOSE 3310