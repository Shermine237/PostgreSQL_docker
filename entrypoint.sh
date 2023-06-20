#!/bin/sh

echo "Welcome, you're logging as $(whoami)";
## Configure postgres
# Change to postgres user
su postgres;
# Create the data directory, and make it less permissive
mkdir /var/lib/postgresql/data && chmod 0700 /var/lib/postgresql/data;
# Create a New Database Cluster with initdb
initdb -D /var/lib/postgresql/data;
# Start the PostgreSQL Database Server with pg_ctl
pg_ctl start -D /var/lib/postgresql/data;
# Start
sh;
