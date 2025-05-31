FROM mk0x/docker-clamav

EXPOSE 3310

# Run freshclam to update virus DB, then start clamd in foreground (-F)
CMD freshclam && clamd -F