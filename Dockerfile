FROM clamav/clamav:latest

EXPOSE 3310/tcp

# Copy custom clamd.conf into container
COPY config/clamd.conf /etc/clamav/clamd.conf

# Update virus definitions
RUN freshclam

# Ensure the socket directory exists
RUN mkdir -p /tmp && chown clamav:clamav /tmp

# Start clamd in the foreground
CMD ["clamd", "--foreground=true"]
