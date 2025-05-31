FROM clamav/clamav:latest

# Update virus databases during build
RUN freshclam

# Copy custom configuration
COPY clamd.conf /etc/clamav/clamd.conf

# Create directory for freshclam
RUN mkdir -p /var/lib/clamav && \
    chown clamav:clamav /var/lib/clamav

# Expose ClamAV TCP port
EXPOSE 3310

# Start freshclam in background (auto-updates every 2 hours)
# and run clamd in foreground
CMD ["sh", "-c", "freshclam -d -c 2 & exec clamd -F"]