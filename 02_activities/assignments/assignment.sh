#!/bin/bash
set -x

############################################
# DSI CONSULTING INC. Project setup script #
############################################

if [ -d newproject ]; then
  echo "Recreating the newproject directory"
  rm -rf newproject
fi
mkdir newproject
cd newproject

mkdir analysis output
touch README.md
touch analysis/main.py

# download client data
curl -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
unzip -q rawdata.zip

###########################################
# Complete assignment here

# 1. Create a directory named data
mkdir data

# 2. Move the contents of ./rawdata to ./data/raw
mkdir -p ./data/raw
mv ./rawdata/* ./data/raw
rmdir ./rawdata

# 3. List the contents of the ./data/raw directory
ls ./data/raw

# 4. Create processed subdirs
mkdir -p ./data/processed
mkdir -p ./data/processed/server_logs ./data/processed/user_logs ./data/processed/event_logs

# 5. Copy server logs
cp ./data/raw/*server*.log ./data/processed/server_logs

# 6. Copy user and event logs
cp ./data/raw/*user_log*.log ./data/processed/user_logs
cp ./data/raw/*event_log*.log ./data/processed/event_logs

# 7. Remove files containing ipaddr
rm ./data/raw/*ipaddr* ./data/processed/user_logs/*ipaddr* 2>/dev/null

# 8. Inventory of processed
find ./data/processed -type f > ./data/inventory.txt

###########################################

echo "Project setup is complete!"
