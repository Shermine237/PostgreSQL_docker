#!/bin/sh

echo "Welcome, you're logging as $(whoami)";

# Start the PostgreSQL Database Server with pg_ctl
doas -u postgres pg_ctl start -D /var/lib/postgresql/data;
# Start shell
sh;
