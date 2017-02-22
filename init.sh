#!/bin/bash

#set -e

###First run###
HOSTNAME=$1
DATABASE_NAME=$3
PASSWORD=$5
PORT_NUMBER=$2
USERNAME=$4
SERVER_DATA=$6

echo "#################################Creating tables#################################"
sudo -u postgres psql -h $1 -p $2 -U $4 $3 < ./scripts/kill_open_db.sql
sudo -u postgres psql -h $1 -p $2 -U $4 postgres < ./scripts/drop_database.sql
sudo -u postgres psql -h $1 -p $2 -U $4 postgres < ./scripts/create_database.sql
sudo -u postgres psql -h $1 -p $2 -U $4 $3 < ./scripts/init_db.sql

echo "#################################INIT JOB DW#################################"

sh kettle/kitchen.sh -file="../ktrs/initjob/initjob.kjb" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################Done#################################"

