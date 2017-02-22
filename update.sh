#!/bin/bash

#set -e

SERVER_DATA=$6
GPS_FOLDER=$7
HOSTNAME=$1
DATABASE_NAME=$3
PASSWORD=$5
PORT_NUMBER=$2
USERNAME=$4

###Updating GPS data###

#echo "Downloading data from database server"
scripts/get_files.sh $SERVER_DATA $GPS_FOLDER

echo "Getting Data Into Local Database"
sh kettle/kitchen.sh -file="../ktrs/datario/1_endpoint_crossing/1 - Starter.kjb" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "Generating Real Trips from GPS Data"

sh kettle/pan.sh -file="../ktrs/datario/2_trip_generation/gen_trip.ktr" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "Transform Data to Dimensions and Fact"

sh kettle/kitchen.sh -file="../ktrs/datario/3_dw_development/export_to_dw.kjb" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME
