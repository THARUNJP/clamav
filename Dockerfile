FROM clamav/clamav:latest
EXPOSE 3310/tcp
RUN ["freshclam"]