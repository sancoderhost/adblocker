#!/bin/bash
if (( EUID != 0 )); then
   echo "You must be root to do this." 1>&2
   exit 100
fi
flag=0
function cleanexit()
        {
        printf "\n caught ctl+c  restoring host files" 
        cp -v  /usr/share/adhost/backhost /etc/hosts
        exit 2

        }
function startup()
{
	printf "#============running first time===============#\n\n "
	touch  /usr/share/adhost/check
 	echo "#------>changing hosts dir  ownership  to root---------#"
        chown -R root:root  * 	
 	echo "#---->setting 755 permision to hosts/ dir--------------#"
 	chmod -R 755  * 
	echo "#- moving --- hostlist file ---- /usr/share/adhost------#";
	mkdir /usr/share/adhost 2>/dev/null 
	cp -v ./adhost2  /usr/share/adhost/

	echo "#-backing up original host ---to /usr/share/adhost/-----#"
	cp -v /etc/hosts /usr/share/adhost/originalhosts
	printf "#===============================================#\n\n"
}

if  pwd |sed 's/.*\///g'|grep -q -v ^hosts ;
then

        echo "script must be run from hosts dir "
	echo "[hint:from unzip  dir ]"
        exit 3
       
fi
if [[ $# -eq 1 ]];
then
	if   echo $1 |grep -q  '^uninstall'  ;
        	then
                	echo "-----uninstalling---adhost---------"
               		echo "----restoring oringinalhost--------"
                	cp -v /usr/share/adhost/originalhosts  /etc/hosts
                	echo "1">./check

                	exit 0
        	else
                	echo "usage ===> adhost2 uninstall "
                	echo "           adhost -h <custom host> "      
			exit 4
	fi
fi 
if [[ $# -eq 2 ]];
then
        if [ "$1" = "-h" ] 
                then
			
			file=$2 
			flag=1
			echo "=====>>using custom host list $2 "
			printf "\n\n"
                       
                else
                        echo "usage ===> adhost2 uninstall "
                        echo "           adhost -h <custom host> "
			exit 4
        fi
fi

                                                                                                   
if [[ $(cat ./check ) -eq 1 ]];
then 
	echo 0 >./check 
	startup 
fi

if ((flag!=1));
then
	file=/usr/share/adhost/adhost2 
fi
stat=0
tot=$(cat $file 2>/dev/null |wc -l 2>/dev/null)
i=1

echo '===backing up hosts===='
cp -v /etc/hosts /usr/share/adhost/backhost 
echo "" >/etc/hosts
if [ -e "$file" ]
then
	while IFS= read  -r  line
	  do	
		trap cleanexit SIGINT   
		echo "---------($i/$tot)---------"
		stat=$(curl -s --head -w %{http_code} $line  -o /dev/null)    

                
 	        if  echo $stat |grep ^2 >/dev/null 
		then
		      
		        
	               	
		     	
			echo " updateing host $line  "
			curl  --progress-bar -# $line >>/etc/hosts
		
		else
 			echo "host domain dont exists  status=$stat " 	
	
        		
		fi
		let 'i=i+1'
	done < $file
else
echo "$file dont exists"
cat /usr/share/adhost/backhost >  /etc/hosts
fi 



