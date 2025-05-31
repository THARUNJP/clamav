FROM ubuntu
#Install requires
RUN apt-get update && apt-get upgrade -y && apt-get install -y clamav \
	clamav-daemon \
	clamav-base \
	clamav-freshclam \
	clamdscan \
	cron vim wget
# Clear cache
EXPOSE 3310
ENTRYPOINT ["clam-start"]
