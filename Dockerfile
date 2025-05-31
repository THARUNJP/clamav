FROM clamav/clamav:stable_base

# Increase startup timeout and reduce checks
ENV CLAMAV_NO_FRESHCLAMD=false \
    CLAMAV_NO_CLAMD=false \
    CLAMAV_NO_MILTERD=true \
    CLAMD_STARTUP_TIMEOUT=600 \  # Increased from 300 to 600 seconds (10 mins)
    FRESHCLAM_CHECKS=4 \  # Reduced checks to 4x/day
    CLAMD_CONCURRENT_RELOAD=no \
    FRESHCLAM_TESTDATABASES=no

# Use TCP healthcheck instead of socket
HEALTHCHECK --interval=30s --timeout=10s --start-period=300s \
  CMD curl -f http://localhost:3310/ || exit 1

EXPOSE 3310