FROM alpine:3.18

LABEL version='2.1.3' arch='x86-64'
# Copy entrypoint.sh file to root image's folder (/)
COPY ./entrypoint.sh /
# Give exec permission to /entrypoint.sh file
RUN chmod +x /entrypoint.sh
# Arguments
ARG NAME=user
ARG PASSWORD=user
# Set environment variables
ENV USER_NAME=$NAME 
ENV USER_PASSWORD=$PASSWORD
# Create user without password (-D) and set password
RUN adduser -D $USER_NAME && echo $USER_NAME:$USER_PASSWORD | chpasswd
# Install doas (it's a lite alternative of sudo) and put user as doas root
RUN apk add --no-cache doas && echo "permit $USER_NAME as root" > /etc/doas.d/doas.conf
# Install postgress, apk auto update before install package
RUN apk add --no-cache postgresql15
# Set user
USER $USER_NAME
# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
# Open PORT
EXPOSE 5432
