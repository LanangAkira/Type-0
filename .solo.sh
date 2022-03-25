#!/bin/bash

# scraping zone-xsec.com
clear
target="https://zone-xsec.com"
attacker_name=$1
check=$(curl -s $target/archive/attacker/$attacker_name)
if [[ -z $check ]]
then
   echo "[$attacker_name] not found"
else
   n=1
   while [ $n -le 50 ]
   do
      page="$target/archive/attacker/$attacker_name/page=$n"
      mirror=$(curl -s $page | sed -r 's/.*href="([^"]+).*/\1/g' | grep /mirror)
      for url in $mirror
      do
         waktu=$(date | awk '{print $4}')
         domain=$(curl -s $target$url | sed 's/<[^>]*>//g' | grep Defacement | awk '{print $4}' | grep http | awk -F "/" '{print $3}')
         echo "$domain" >> ResultBot/$attacker_name.txt
         echo -e "\e[93m[$waktu]\e[0m >>> \e[92m$domain\e[0m"
      done
      n=$(expr $n + 1)
   done
fi

