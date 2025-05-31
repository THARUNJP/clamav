# Use the official ClamAV image
FROM clamav/clamav:latest

# Expose the ClamAV TCP port
EXPOSE 3310

# Start ClamAV daemon in the foreground (so container stays running)
CMD ["clamd", "-F"]
