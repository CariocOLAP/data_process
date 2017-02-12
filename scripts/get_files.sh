#usage get_files {SERVER_DOMAIN} {ZIP_FOLDERS}
rsync -tP $1:$2/* ../bus_data/
