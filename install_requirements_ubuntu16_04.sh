sudo apt install postgresql-9.5
sudo apt install postgresql-9.5-postgis-scripts

sudo -u postgres psql < ./scripts/install_pg_extensions.sql
