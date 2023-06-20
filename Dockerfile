FROM alpine:3.18

LABEL version='3.0.1' arch='x86-64'
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
# Install postgress, apk auto update before install package
    apk add --no-cache postgresql15 postgresql15-client
### Configure postgres
# Create Required Folders for PostgreSQL
RUN mkdir /run/postgresql && chown postgres:postgres /run/postgresql/; \
# Change to postgres user and Create the data directory, and make it less permissive 
    su postgres; \
    mkdir /var/lib/postgresql/data && chmod 0700 /var/lib/postgresql/data; \
# Create a New Database Cluster with initdb
    initdb -D /var/lib/postgresql/data; \
# Start the PostgreSQL Database Server with pg_ctl
    pg_ctl start -D /var/lib/postgresql/data 
# Set user
USER $USER_NAME
# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
# Open PORT
EXPOSE 5432
