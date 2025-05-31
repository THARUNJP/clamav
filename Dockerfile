FROM clamav/clamav:stable_base

# Optimize for Railway deployment
ENV CLAMAV_NO_FRESHCLAMD=false \
    CLAMAV_NO_CLAMD=false \
    CLAMAV_NO_MILTERD=true \
    CLAMD_STARTUP_TIMEOUT=300 \
    FRESHCLAM_CHECKS=12 \  # Check every 2 hours
    CLAMD_CONCURRENT_RELOAD=no \  # Save memory
    FRESHCLAM_TESTDATABASES=no  # Save memory during updates

# Create volume for databases
VOLUME /var/lib/clamav

# Expose clamd port
EXPOSE 3310

# Health check using clamd's TCP listener
HEALTHCHECK --interval=30s --timeout=10s \
  CMD echo PING | nc localhost 3310 | grep -q PONG || exit 1

# Keep default entrypoint
