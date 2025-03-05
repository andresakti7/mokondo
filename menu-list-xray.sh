#!/bin/bash
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
RED='\033[0;31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
LRED='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
grenbo="\e[92;1m"
blue="\033[0;34m"
Blue="\033[36m"
BICyan='\033[1;96m'       # Cyan
Greenlight="\e[92;1m"
yellow='\033[0;33m'
WhiteB="\e[0;37m"

REPO="https://raw.githubusercontent.com/andresakti7/mokondo/main/"
file1231="/etc/xray/vxray"

rm -rf /etc/xray/xray_list.txt
touch /etc/xray/xray_list.txt

if [[ ! -f "$file1231" || ! -s "$file1231" ]]; then
    rm -rf "$file1231"
    touch "$file1231"
    # Ambil versi xray dan simpan ke dalam file
    xray --version | grep -oP 'Xray \d+\.\d+\.\d+' > "$file1231"
    echo "Versi Xray telah disimpan ke dalam $file1231."
fi

function update_list_xray(){
clear
    #print_install "Backup Auto"
    # Nama file untuk menyimpan daftar versi
    OUTPUT_FILE="/etc/xray/xray_list.txt"

    # URL API GitHub untuk mendapatkan rilis XRay
    API_URL="https://api.github.com/repos/XTLS/Xray-core/releases"

    # Mengambil data rilis dari GitHub menggunakan curl dan jq, lalu menyimpan ke file
    curl -s $API_URL | jq -r '.[] | .tag_name' > $OUTPUT_FILE

    #echo "Daftar versi XRay telah disalin ke $OUTPUT_FILE."

    clear
}
update_list_xray

# Fungsi untuk memeriksa dan menginstal jq
check_and_install_jq() {
    if ! command -v jq &> /dev/null; then
        echo "jq belum terinstal. Menginstal jq..."
        sudo apt update
        sudo apt install -y jq
    else
        echo "jq sudah terinstal."
    fi
}

# Fungsi untuk memeriksa dan menginstal sqlite3
check_and_install_sqlite3() {
    if ! command -v sqlite3 &> /dev/null; then
        echo "sqlite3 belum terinstal. Menginstal sqlite3..."
        sudo apt update
        sudo apt install -y sqlite3
    else
        echo "sqlite3 sudah terinstal."
    fi
}

# Cek dan install jq
check_and_install_jq

# Cek dan install sqlite3
check_and_install_sqlite3


# Folder yang ingin dicek
FOLDER="/usr/local/bin/installxray"

check_folder() {
    # Cek apakah folder sudah ada
    if [ ! -d "$FOLDER" ]; then
        echo "Folder $FOLDER tidak ditemukan. Membuat folder..."
        sudo mkdir -p "$FOLDER"
        echo "Folder $FOLDER telah dibuat."
    else
        echo "Folder $FOLDER sudah ada."
    fi
}

check_folder

# Fungsi untuk menampilkan menu pilihan versi Xray
select_xray_version() {
    # Membaca versi Xray dari file /etc/xray/xray_list.txt
    if [ ! -f /etc/xray/xray_list.txt ]; then
        echo "File /etc/xray/xray_list.txt tidak ditemukan!"
        exit 1
    fi
    # // Trojan Proxy
    ss=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
    if [[ $ss == "running" ]]; then
        status_ss="${Greenlight}Online$NC${Greenlight}$NC"
    else
        status_ss="${RED}Offline${NC} "
    fi
    # File daftar versi
    VERSION_FILE="/etc/xray/xray_list.txt"
    xray_core=$(grep -oP 'Xray \d+\.\d+\.\d+' /etc/xray/vxray | sed 's/Xray /v/')
    if [ -z "$xray_core" ]; then
        status_xray_core="${RED}Xray belum diinstall${NC} "
    else
        status_xray_core=$(grep -oP 'Xray \d+\.\d+\.\d+' /etc/xray/vxray | sed 's/Xray /v/')
    fi
    # Menampilkan daftar versi dengan warna
    echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━◇\033[0m"
	echo -e "       XRAY VERSION STATUS        "
	echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━◇\033[0m"
	echo "" 
	echo -e "${WhiteB}Xray Core${WhiteB} ${BICyan}:${BICyan} ${yellow}${Bold}${status_xray_core}${Bold}${yellow}"
	echo -e "${WhiteB}Trojan${WhiteB}    ${BICyan}:${BICyan} ${Bold}${status_ss}${Bold}"
	echo -e "${WhiteB}Vmess${WhiteB}     ${BICyan}:${BICyan} ${Bold}${status_ss}${Bold}"
	echo -e "${WhiteB}Vless${WhiteB}     ${BICyan}:${BICyan} ${Bold}${status_ss}${Bold}"
	echo "" 
	echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━◇\033[0m"
	echo "" 
    echo "Pilih versi yang diinginkan:"
    awk '{printf "\033[1;37m%d) \033[1;36m%s\n\033[0m", NR, $0}' "$VERSION_FILE"

    # Meminta pengguna untuk memilih versi
	echo -e "\033[1;93m◇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━◇\033[0m"
	echo "" 
    echo -n "Masukkan nomor versi (atau 'x' untuk keluar): "
    read selection

    # Mengecek apakah pengguna ingin keluar
    if [[ "$selection" == "x" ]]; then
        echo "Keluar dari pemilihan versi."
        exit 0
    fi
    clear
    # Mengecek apakah pilihan valid
    if [[ "$selection" =~ ^[0-9]+$ ]]; then
        VERSION=$(sed -n "${selection}p" "$VERSION_FILE")
        if [ -n "$VERSION" ]; then
            echo "Anda memilih versi: $VERSION"
        else
            echo "Versi tidak ditemukan. Pilihan tidak valid."
        fi
    else
        echo "Masukan tidak valid. Harap masukkan nomor versi yang benar."
    fi
}

# Fungsi untuk instalasi Xray
install_xray() {
    clear
    select_xray_version  # Memanggil fungsi untuk memilih versi Xray
    
    echo "Memulai instalasi Core Xray $VERSION"

     Hentikan dan nonaktifkan layanan xray
    systemctl stop xray
    systemctl disable xray

    # Hapus file xray yang ada
    rm /usr/local/bin/xray

    rm -rf /usr/local/bin/installxray
    mkdir -p /usr/local/bin/installxray
    # Unduh versi terbaru xray
    wget https://github.com/XTLS/Xray-core/releases/download/$VERSION/Xray-linux-64.zip -O /usr/local/bin/installxray/Xray-linux-64.zip

    # Instal unzip jika belum terinstal
    apt install -y unzip

    # Ekstrak file zip
    unzip /usr/local/bin/installxray/Xray-linux-64.zip -d /usr/local/bin/installxray/

    # Pindahkan file xray ke lokasi yang benar
    mv /usr/local/bin/installxray/xray /usr/local/bin/

    # Berikan izin eksekusi pada file xray
    chmod +x /usr/local/bin/xray

    # Hapus file zip setelah selesai
    #rm -rf /usr/local/bin/installxray

    # Reload daemon systemd
    systemctl daemon-reload

    # Aktifkan dan mulai layanan xray
    systemctl enable xray
    systemctl start xray

    # Tampilkan status layanan xray
    systemctl status xray

    # Tampilkan versi xray
    /usr/local/bin/xray --version
	
    echo "Konfigurasi Packet XRAY selesai"
}

# Memanggil fungsi untuk menginstal Xray
install_xray


# Fungsi untuk instalasi Xray
Finishing_xray() {
    clear
    # Lokasi file
    file1="/etc/xray/vxray"

    # Periksa keberadaan file
    if [ -e "$file1" ]; then
        # Jika file ada, hapus file tersebut
        rm -f "$file1"
        echo "File $file1 telah dihapus."
    else
        # Jika file tidak ada, buat file baru
        echo "File $file1 tidak ditemukan, akan dibuat."
    fi
    
    rm -rf /etc/xray/vxray
    touch /etc/xray/vxray
    # Ambil versi xray dan simpan ke dalam file
    xray --version | grep -oP 'Xray \d+\.\d+\.\d+' > "$file1"
    echo "Versi Xray telah disimpan ke dalam $file1."
    xray_core=$(grep -oP 'Xray \d+\.\d+\.\d+' /etc/xray/vxray | sed 's/Xray /v/')
    clear
    menu-list-xray.sh
}

Finishing_xray
