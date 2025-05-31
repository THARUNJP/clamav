FROM clamav/clamav:stable_base

# Optimize for Railway deployment
ENV CLAMAV_NO_FRESHCLAMD=false \
    CLAMAV_NO_CLAMD=false \
    CLAMAV_NO_MILTERD=true \
    CLAMD_STARTUP_TIMEOUT=300 \
    FRESHCLAM_CHECKS=12 \
    CLAMD_CONCURRENT_RELOAD=no \
    FRESHCLAM_TESTDATABASES=no

# Expose clamd port
EXPOSE 3310

# Health check using clamd's TCP listener
HEALTHCHECK --interval=30s --timeout=10s \
  CMD echo PING | nc localhost 3310 | grep -q PONG || exit 1

# Keep default entrypoint