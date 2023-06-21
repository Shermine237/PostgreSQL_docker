#!/bin/sh

echo "Welcome, you're logging as $(whoami)";

# Create a New Database Cluster with initdb
initdb -D /var/lib/postgresql/data;
# Start the PostgreSQL Database Server with pg_ctl
pg_ctl start -D /var/lib/postgresql/data;
# Start shell
sh;
