FROM debian:11-slim

LABEL version='1.0.1' arch='x86-64'
# Create folder
RUN mkdir /volume-folder
# Set volume
VOLUME /volume-folder
# Copy entrypoint.sh file to root image's folder (/)
COPY ./entrypoint.sh /
# Give exec permission to /entrypoint.sh file
RUN chmod +x /entrypoint.sh
# Install postgress
RUN apt-get update && apt-get install postgresql postgresql-contrib -y && apt-get clean
# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
# Open PORT
EXPOSE 5432
