#!/bin/bash

#set -e

###First run###
HOSTNAME=$1
DATABASE_NAME=$3
PASSWORD=$5
PORT_NUMBER=$2
USERNAME=$4

echo "#################################Creating tables#################################"
sudo -u postgres psql < ./scripts/drop_database.sql
sudo -u postgres psql < ./scripts/create_database.sql
sudo -u postgres psql < ./scripts/init_db.sql

echo "#################################Loading Extra Data Into DW#################################"
#sh kettle/pan.sh -file="../ktrs/extra/load_extra_data.ktr" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################Loading Fetranspor Data into DW#################################"
#sh kettle/pan.sh -file="../ktrs/fetranspor/empresa_linha.ktr" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################Loading Social Data (From 2010 IBGE census) into DW#################################"

echo "#################################dm_atividade_mte.ktr#################################"
#sh kettle/pan.sh -file="../ktrs/social/dm_atividade_mte.ktr" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################dm_atividade_principal.ktr#################################"
#sh kettle/pan.sh -file="../ktrs/social/dm_atividade_principal.ktr" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################dm_faixa_salarial.ktr#################################"
#sh kettle/pan.sh -file="../ktrs/social/dm_faixa_salarial.ktr" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################dm_local.ktr#################################"
#sh kettle/pan.sh -file="../ktrs/social/dm_local.ktr" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################fato_ocupacao.ktr#################################"
#sh kettle/kitchen.sh -file="../ktrs/social/fato_ocupacao.kjb" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################fato_postos_trabalho.ktr#################################"
#sh kettle/kitchen.sh -file="../ktrs/social/fato_postos_trabalho.kjb" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################fato_renda.ktr#################################"
#sh kettle/kitchen.sh -file="../ktrs/social/fato_renda.kjb" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################fato_trabalho_deslocamento#################################"
#sh kettle/kitchen.sh -file="../ktrs/social/fato_trabalho_deslocamento.kjb" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

echo "#################################Done#################################"

echo "#################################Getting planned trips data#################################"

echo "#################################Stage Trajeto#################################"
sh kettle/pan.sh -file="../ktrs/datario/stage_trajeto.ktr" -param:DATABASE_NAME=$DATABASE_NAME -param:PASSWORD=$PASSWORD -param:PORT_NUMBER=$PORT_NUMBER -param:USERNAME=$USERNAME -param:HOSTNAME=$HOSTNAME

