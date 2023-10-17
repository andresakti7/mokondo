
res1() {
    wget https://raw.githubusercontent.com/andresakti7/mokondo/main/menu/menu.zip
    unzip menu.zip
    7z e -p KrustyCrab2023!KrustyCrab2023!
    chmod +x /root/menu/*
    mv /root/menu/* /usr/local/sbin/
    rm -rf menu
    rm -rf menu.zip
    rm -rf update.sh
}
netfilter-persistent
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          SCRIPT HAS BEEN UPDATED        \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "  \033[1;91m update script service\033[1;37m"
#fun_bar 'res1'
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -n 1 -s -r -p "Press [ Enter ] to back on menu"
menu

###########- COLOR CODE -##############
