#Instal Menu
# REPO    
    REPO="https://raw.githubusercontent.com/andresakti7/mokondo/main/"
function menu(){
    clear
    print_install "Memasang Menu Packet"
    wget -O ~/menu.zip "${REPO}menu/menu.zip" >/dev/null 2>&1
    mkdir /root/menu
    unzip menu.zip; -o/root/menu/ >/dev/null 2>&1
#    7z e -pmeki   ~/menu.zip -o/root/menu/ >/dev/null 2>&1
    chmod +x /root/menu/*
    mv /root/menu/* /usr/local/sbin/
    #botmintod
    wget ${REPO}menu/botmin.zip
    unzip botmin.zip
    mv adminbot /etc
    rm *.zip
    touch /etc/adminbot/var.txt
}
