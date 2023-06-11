FROM alpine:3.18

LABEL version='2.0.2' arch='x86-64'
# Copy entrypoint.sh file to root image's folder (/)
COPY ./entrypoint.sh /
# Give exec permission to /entrypoint.sh file
RUN chmod +x /entrypoint.sh
# Install postgress, apk auto update before install package
RUN apk add --no-cache postgresql15 
# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
# Open PORT
EXPOSE 5432
