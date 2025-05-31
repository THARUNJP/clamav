FROM debian:bullseye

# Update & install ClamAV and daemon
RUN apt-get update && \
    apt-get install -y clamav clamav-daemon && \
    rm -rf /var/lib/apt/lists/*

# Update virus definitions
RUN freshclam

# Ensure the clamav user has necessary permissions
RUN mkdir -p /var/run/clamav && \
    chown clamav:clamav /var/run/clamav

# Expose ClamAV daemon port
EXPOSE 3310

# Set working directory
WORKDIR /app

# Start clamd as the default command
CMD ["clamd", "--foreground", "--config-file=/etc/clamav/clamd.conf"]
