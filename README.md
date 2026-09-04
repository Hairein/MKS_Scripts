# MKS_Scripts
Micah Koleoso Software - Public scripts and documents

## MKS Platform Site

The use of these files below are described in the documentation to the product here at [MKS Platform Site User Guide (PDF)](https://micahkoleososoftware.com/data/mksps_user_guide.pdf).

Generally other databses or MySQL databse version can be used in this setup though some SQL commands in the scripts may need to be adjusted.

### setup_mksps_db.sql 
SQL script to create and setup a MySQL database for use with the MKS Platform Site product.

To get the file per command line:
```bash
wget -O setup_mksps_db.sql https://raw.githubusercontent.com/Hairein/MKS_Scripts/main/setup_mksps_db.sql
```
or
```bash
curl -o setup_mksps_db.sql https://raw.githubusercontent.com/Hairein/MKS_Scripts/main/setup_mksps_db.sql
```

### Quickstart Files
To quickly setup a single platform of the MKS Platform Site, you can use the two given scripts below.

Get the files per command line:
```bash
wget -O setup_mksps_db.sql https://raw.githubusercontent.com/Hairein/MKS_Scripts/main/docker-compose.yml
wget -O setup_mksps_db.sql https://raw.githubusercontent.com/Hairein/MKS_Scripts/main/setup_database_structure.sh
```
NOTE: You will need to provide a root password for the database and adjust the database connection string for the other components in the docker-compose.yml file. In the file setup_database_structure.sh you will need to set the MYSQL_ROOT_PASSWORD value appropriately before running as described below.

To start with Docker Compose, make sure the file docker-compose.yml is in the current directory where you ant to start from:
```bash
docker compose up -d
```

Run the script once the setup is running healthy (depends on your shell):
```bash
./setup_database_structure.sh or
bash setup_database_structure.sh or
sh setup_database_structure.sh 
```

To stop the entire setup:
```bash
docker compose down
```

The entire setup runs on a single computer to enable to see it running. However, the main aim of the software is to manage multiple platforms and start applications on them dynamically.

## Further Information

For further information visit us at [Micah Koleoso Software](https://www.micahkoleososoftware.com)