FROM clamav/clamav:latest

EXPOSE 3310/tcp

# Update virus definitions
RUN ["freshclam"]

# Reconfigure clamav-daemon in non-interactive mode
