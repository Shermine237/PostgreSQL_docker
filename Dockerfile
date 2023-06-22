FROM alpine:3.18

LABEL version='3.0.5' arch='x86-64'
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
RUN adduser -D $USER_NAME && echo $USER_NAME:$USER_PASSWORD | chpasswd; \
# Install doas (it's a lite alternative of sudo) and put user as doas root
    apk add --no-cache doas && echo "permit $USER_NAME as root" > /etc/doas.d/doas.conf; \
    echo "permit nopass root as postgres cmd initdb" >> /etc/doas.d/doas.conf; \
    echo "permit nopass $USER_NAME as postgres cmd pg_ctl" >> /etc/doas.d/doas.conf; \
# Install postgress, apk auto update before install package
    apk add --no-cache postgresql15 postgresql15-client; \
# Create Required Folders for PostgreSQL
    mkdir /run/postgresql && chown postgres:postgres /run/postgresql; \
# Create the data directory, and make it less
    mkdir /var/lib/postgresql/data && chown postgres:postgres /var/lib/postgresql/data; \
# Create a New Database Cluster with initdb
    doas -u postgres initdb -D /var/lib/postgresql/data
# Set user
USER $USER_NAME
# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
# Open PORT
EXPOSE 5432
