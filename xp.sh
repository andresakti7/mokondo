#!/bin/bash
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
clear
echo -n > /var/log/xray/access.log
echo -n > /var/log/nginx/access.log
echo -n > /var/log/xray_autoremove.log
##----- Auto Remove Vmess
data=($(cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq))
now=$(date +"%Y-%m-%d")
for user in "${data[@]}"; do
    exp=$(grep -w "^### $user" "/etc/vmess/.vmess.db" | cut -d ' ' -f 3 | sort | uniq)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(((d1 - d2) / 86400))
    exp4=$(grep -w "^### $user" "/etc/vmess/.vmess.db" | cut -d ' ' -f 3 | sort | uniq)
    uuid=$(grep -w "^### $user" "/etc/vmess/.vmess.db" | cut -d ' ' -f 4 | sort | uniq)
    exp02=$(grep -w "^### $user" "/etc/vmess/.vmess1.db" | cut -d ' ' -f 3 | sort | uniq)
    expe=$(grep -w "^### $user" "/etc/vmess/.vmess1.db" | cut -d ' ' -f 7-9 | sort | uniq)
    tnggl=$(grep -w "^### $user" "/etc/vmess/.vmess1.db" | cut -d ' ' -f 4-6 | sort | uniq)
    uuids=$(grep -w "^### $user" "/etc/vmess/.vmess1.db" | cut -d ' ' -f 10 | sort | uniq)
    Quota=$(grep -w "^### $user" "/etc/vmess/.vmess1.db" | cut -d ' ' -f 11 | sort | uniq)
    iplim=$(grep -w "^### $user" "/etc/vmess/.vmess1.db" | cut -d ' ' -f 12 | sort | uniq)
    if [[ "$exp2" -le "0" ]]; then
        sed -i "/^### $user $exp4 $uuid/d" /etc/vmess/.userexp.db
          if [[ ${exp4} != '' && ${uuid} != '' ]]; then
        echo -e "### $user $exp4 $uuid" >> /etc/vmess/.userexp.db
      fi
        echo "Menghapus user $user VMESS yang expired pada $exp" >> /var/log/xray_autoremove.log
        #rm -f /etc/vmess/limit-quota/$user
        #rm -f /etc/vmess/limit-ip/$user
        #rm -f /etc/limit/vmess/$user
        #rm -f /etc/limit/upload/vmess/$user
        #sed -i "/^### $user $exp $uuid/d" /etc/vmess/.vmess.db
        #sed -i "/^### $user $exp02 $tnggl $expe $uuids $Quota $iplim/d" /etc/vmess/.vmess1.db
        rm -f /etc/vmess/limit-quota/$user /etc/vmess/limit-ip/$user /etc/limit/vmess/$user /etc/limit/upload/vmess/$user
        sed -i "/^### $user\b/d" /etc/vmess/.vmess.db /etc/vmess/.vmess1.db /etc/vmesstrial/.vmesstrial.db
        sed -i "/^### $user/,/^},{/d" /etc/xray/config.json
        #sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
        #sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
    	files=(
    	    "/etc/vmess/limit-quota/$user"
    	    "/etc/vmess/limit-ip/$user"
    	    "/etc/limit/vmess/$user"
    	    "/etc/limit/upload/vmess/$user"
    	)
    	for file in "${files[@]}"; do
    	    if [ -f "$file" ]; then
    	        rm -f "$file"
    	    fi
    	done
        #rm -f /etc/vmess/limit-quota/$user
        #rm -f /etc/vmess/limit-ip/$user
        #rm -f /etc/limit/vmess/$user
        #rm -f /etc/limit/upload/vmess/$user
        [[ -x /usr/local/sbin/fixdbrecovery.sh ]] && /usr/local/sbin/fixdbrecovery.sh
    fi
done

#----- Auto Remove Vless
data=($(cat /etc/xray/config.json | grep '^#&' | cut -d ' ' -f 2 | sort | uniq))
now=$(date +"%Y-%m-%d")
for user in "${data[@]}"; do
    exp=$(grep -w "^### $user" "/etc/vless/.vless.db" | cut -d ' ' -f 3 | sort | uniq)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(((d1 - d2) / 86400))
    exp4=$(grep -w "^### $user" "/etc/vless/.vless.db" | cut -d ' ' -f 3 | sort | uniq)
    uuid=$(grep -w "^### $user" "/etc/vless/.vless.db" | cut -d ' ' -f 4 | sort | uniq)
    exp02=$(grep -w "^### $user" "/etc/vless/.vless1.db" | cut -d ' ' -f 3 | sort | uniq)
    expe=$(grep -w "^### $user" "/etc/vless/.vless1.db" | cut -d ' ' -f 7-9 | sort | uniq)
    tnggl=$(grep -w "^### $user" "/etc/vless/.vless1.db" | cut -d ' ' -f 4-6 | sort | uniq)
    uuids=$(grep -w "^### $user" "/etc/vless/.vless1.db" | cut -d ' ' -f 10 | sort | uniq)
    Quota=$(grep -w "^### $user" "/etc/vless/.vless1.db" | cut -d ' ' -f 11 | sort | uniq)
    iplim=$(grep -w "^### $user" "/etc/vless/.vless1.db" | cut -d ' ' -f 12 | sort | uniq)
    if [[ "$exp2" -le "0" ]]; then
        sed -i "/^### $user $exp4 $uuid/d" /etc/vless/.userexp.db
          if [[ ${exp4} != '' && ${uuid} != '' ]]; then
        echo -e "### $user $exp4 $uuid" >> /etc/vless/.userexp.db
      fi
        echo "Menghapus user $user VLESS yang expired pada $exp" >> /var/log/xray_autoremove.log
        #rm -f /etc/vless/limit-quota/$user
        #rm -f /etc/vless/limit-ip/$user
        #rm -f /etc/limit/vless/$user
        #rm -f /etc/limit/upload/vless/$user
        #sed -i "/^### $user $exp $uuid/d" /etc/vless/.vless.db
        #sed -i "/^### $user $exp02 $tnggl $expe $uuids $Quota $iplim/d" /etc/vless/.vless1.db
        rm -f /etc/vless/limit-quota/$user /etc/vless/limit-ip/$user /etc/limit/vless/$user /etc/limit/upload/vless/$user
        sed -i "/^### $user\b/d" /etc/vless/.vless.db /etc/vless/.vless1.db /etc/vlesstrial/.vlesstrial.db
        sed -i "/^#& $user/,/^},{/d" /etc/xray/config.json
        #sed -i "/^#& $user $exp/,/^},{/d" /etc/xray/config.json
        #sed -i "/^#& $user $exp/,/^},{/d" /etc/xray/config.json
		files=(
		    "/etc/vless/limit-quota/$user"
		    "/etc/vless/limit-ip/$user"
		    "/etc/limit/vless/$user"
		    "/etc/limit/upload/vless/$user"
		)
		for file in "${files[@]}"; do
		    if [ -f "$file" ]; then
		        rm -f "$file"
		    fi
		done
        #rm -f /etc/vless/limit-quota/$user
        #rm -f /etc/vless/limit-ip/$user
        #rm -f /etc/limit/vless/$user
        #rm -f /etc/limit/upload/vless/$user
        [[ -x /usr/local/sbin/fixdbrecovery.sh ]] && /usr/local/sbin/fixdbrecovery.sh
    fi
done

#----- Auto Remove Trojan
data=($(cat /etc/xray/config.json | grep '^#!' | cut -d ' ' -f 2 | sort | uniq))
now=$(date +"%Y-%m-%d")
for user in "${data[@]}"; do
    exp=$(grep -w "^### $user" "/etc/trojan/.trojan.db" | cut -d ' ' -f 3 | sort | uniq)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(((d1 - d2) / 86400))
    exp4=$(grep -w "^### $user" "/etc/trojan/.trojan.db" | cut -d ' ' -f 3 | sort | uniq)
    uuid=$(grep -w "^### $user" "/etc/trojan/.trojan.db" | cut -d ' ' -f 4 | sort | uniq)
    exp02=$(grep -w "^### $user" "/etc/trojan/.trojan1.db" | cut -d ' ' -f 3 | sort | uniq)
    expe=$(grep -w "^### $user" "/etc/trojan/.trojan1.db" | cut -d ' ' -f 7-9 | sort | uniq)
    tnggl=$(grep -w "^### $user" "/etc/trojan/.trojan1.db" | cut -d ' ' -f 4-6 | sort | uniq)
    uuids=$(grep -w "^### $user" "/etc/trojan/.trojan1.db" | cut -d ' ' -f 10 | sort | uniq)
    Quota=$(grep -w "^### $user" "/etc/trojan/.trojan1.db" | cut -d ' ' -f 11 | sort | uniq)
    iplim=$(grep -w "^### $user" "/etc/trojan/.trojan1.db" | cut -d ' ' -f 12 | sort | uniq)
    if [[ "$exp2" -le "0" ]]; then
        sed -i "/^### $user $exp4 $uuid/d" /etc/trojan/.userexp.db
          if [[ ${exp4} != '' && ${uuid} != '' ]]; then
        echo -e "### $user $exp4 $uuid" >> /etc/trojan/.userexp.db
      fi
        echo "Menghapus user $user TROJAN yang expired pada $exp" >> /var/log/xray_autoremove.log
        #rm -f /etc/trojan/limit-quota/$user
        #rm -f /etc/trojan/limit-ip/$user
        #rm -f /etc/limit/trojan/$user
        #rm -f /etc/limit/upload/trojan/$user
        #sed -i "/^### $user $exp $uuid/d" /etc/trojan/.trojan.db
        #sed -i "/^### $user $exp02 $tnggl $expe $uuids $Quota $iplim/d" /etc/trojan/.trojan1.db
        rm -f /etc/trojan/limit-quota/$user /etc/trojan/limit-ip/$user /etc/limit/trojan/$user /etc/limit/upload/trojan/$user
        sed -i "/^### $user\b/d" /etc/trojan/.trojan.db /etc/trojan/.trojan1.db /etc/trojantrial/.trojantrial.db
        sed -i "/^#! $user/,/^},{/d" /etc/xray/config.json
        #sed -i "/^#! $user/,/^},{/d" /etc/xray/config.json
        #sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
        #sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
    	files=(
    	    "/etc/trojan/limit-quota/$user"
    	    "/etc/trojan/limit-ip/$user"
    	    "/etc/limit/trojan/$user"
    	    "/etc/limit/upload/trojan/$user"
    	)
    	for file in "${files[@]}"; do
    	    if [ -f "$file" ]; then
    	        rm -f "$file"
    	    fi
    	done
        #rm -f /etc/trojan/limit-ip/$user
        #rm -f /etc/limit/trojan/$user
        #rm -f /etc/limit/upload/trojan/$user
        [[ -x /usr/local/sbin/fixdbrecovery.sh ]] && /usr/local/sbin/fixdbrecovery.sh
    fi
done

#----- Auto Remove SS
data=($(cat /etc/xray/config.json | grep '^#S#' | cut -d ' ' -f 2 | sort | uniq))
now=$(date +"%Y-%m-%d")
for user in "${data[@]}"; do
    exp=$(grep -w "^#S# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(((d1 - d2) / 86400))
    if [[ "$exp2" -le "0" ]]; then
        rm -f /etc/shadowsocks/$user
        rm -f /etc/limit/shadowsocks
        sed -i "/\b${user}\b/d" /etc/shadowsocks/.shadowsocks.db
		sed -i "/^#S# $user/,/^},{/d" /etc/xray/config.json
    fi
done
systemctl restart xray

#----- Auto Remove SSH
data=($(cat /etc/ssh/.ssh.db | grep '^###' | cut -d ' ' -f 2 | sort | uniq))
now=$(date +"%Y-%m-%d")
for user in "${data[@]}"; do
    exp=$(grep -w "^### $user" "/etc/ssh/.ssh.db" | cut -d ' ' -f 4 | sort | uniq)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(((d1 - d2) / 86400))
    exp4=$(grep -w "^### $user" "/etc/ssh/.ssh.db" | cut -d ' ' -f 4 | sort | uniq)
    pwd=$(grep -w "^### $user" "/etc/ssh/.ssh.db" | cut -d ' ' -f 3 | sort | uniq)
    Pass=$(grep -w "^### $user" "/etc/ssh/.ssh1.db" | cut -d ' ' -f 3 | sort | uniq)
    expi=$(grep -w "^### $user" "/etc/ssh/.ssh1.db" | cut -d ' ' -f 4 | sort | uniq)
    limiip=$(grep -w "^### $user" "/etc/ssh/.ssh1.db" | cut -d ' ' -f 5 | sort | uniq)
    Quota11=$(grep -w "^### $username" "/etc/ssh/.ssh1.db" | cut -d ' ' -f 6 | sort | uniq)
    if [[ "$exp2" -le "0" ]]; then
        sed -i "/^### $user $exp4 $pwd/d" /etc/ssh/.userexp.db
          if [[ ${exp4} != '' && ${pwd} != '' ]]; then
        echo -e "### $user $exp4 $pwd" >> /etc/ssh/.userexp.db
      fi
	    echo "Menghapus user $user SSH yang expired pada $exp" >> /var/log/xray_autoremove.log
        #rm -f /etc/ssh/limit-quota/$user
        #rm -f /etc/limit/ssh/$user
        #rm -f /etc/ssh/limit-ip/$user
        #sed -i "/^### $user $pwd $exp4/d" /etc/ssh/.ssh.db
        #sed -i "/^### $user $exp4/d" /etc/ssh/.ssh.db
        #sed -i "/^### $user $Pass $expi $limiip $Quota11/d" /etc/ssh/.ssh1.db
        #sed -i "/\b${user}\b/d" /etc/sshtrial/.sshtrial.db
        rm -f /etc/ssh/limit-quota/$user /etc/limit/ssh/$user /etc/ssh/limit-ip/$user
        sed -i "/^### $user\b/d" /etc/ssh/.ssh.db /etc/ssh/.ssh1.db /etc/sshtrial/.sshtrial.db
        userdel $user > /dev/null 2>&1
        #rm -f /etc/ssh/limit-quota/$user
        #rm -f /etc/limit/ssh/$user
        #rm -f /etc/ssh/limit-ip/$user
        files=(
            "/etc/ssh/limit-ip/$user"
            "/etc/ssh/limit-quota/$user"
            "/etc/limit/ssh/$user"
        )
        # Loop melalui setiap file
        for file in "${files[@]}"; do
            if [ -f "$file" ]; then
                rm -f "$file"
            fi
        done
        [[ -x /usr/local/sbin/fixdbrecovery.sh ]] && /usr/local/sbin/fixdbrecovery.sh
    fi
done
systemctl reload ssh

fixdbrecovery.sh
backup-auto
lwp-released
limiterr
bw-usage

##------ Auto Remove SSH
#hariini=$(date +%d-%m-%Y)
#cat /etc/shadow | cut -d: -f1,8 | sed /:$/d >/tmp/expirelist.txt
#totalaccounts=$(cat /tmp/expirelist.txt | wc -l)
#for ((i = 1; i <= $totalaccounts; i++)); do
#    tuserval=$(head -n $i /tmp/expirelist.txt | tail -n 1)
#    username=$(echo $tuserval | cut -f1 -d:)
#    userexp=$(echo $tuserval | cut -f2 -d:)
#    userexpireinseconds=$(($userexp * 86400))
#    tglexp=$(date -d @$userexpireinseconds)
#    tgl=$(echo $tglexp | awk -F" " '{print $3}')
#    exp4=$(cat /etc/ssh/.ssh.db | grep "${user}" | cut -d ' ' -f 4)
#    pwd=$(cat /etc/ssh/.ssh.db | grep "${user}" | cut -d ' ' -f 3)
#    while [ ${#tgl} -lt 2 ]; do
#        tgl="0"$tgl
#    done
#   while [ ${#username} -lt 15 ]; do
#        username=$username" "
#    done
#    bulantahun=$(echo $tglexp | awk -F" " '{print $2,$6}')
#    todaystime=$(date +%s)
#    if [ $userexpireinseconds -ge $todaystime ]; then
#        :
#    else
#        userdel --force $username
#        echo -e ### $username $exp4 $pwd >> /etc/ssh/.userexp.db
#        sed -i "/\b${username}\b/d" /etc/ssh/.ssh.db
#        sed -i "/\b${username}\b/d" /etc/ssh/.ssh1.db
#    fi
#done
#systemctl reload ssh
