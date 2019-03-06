#!/usr/bin/bash
mkdir DBMS
d=$(pwd -L -P)
export d
function menuItems {
echo "1) create database"
echo "2) choose database"
echo "3) delete database"
echo "4) exit"
echo "5)show databases"
}
regex='^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$'
#ctab=``
export ctab
clear
select choice in "create database" "choose database" "delete databas" "exit" "show database"
do
case $REPLY in
1) 
   cd "$d/DBMS"
   while true
   do
   echo "enter database name?"
   read named
   if test -d $named
   then
   echo "database exist or you entered an invalid name"
   sleep 2
   clear
   menuItems
   else
   if [[ $named =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
   then
   export named
   echo "$named is created"
   mkdir $named
   sleep 1
   clear
   break
   else
   echo "Invalid name"
   fi
   fi
   done
   clear
   menuItems
       ;;
2) echo "choose database"
   cd "$d/DBMS"
   ls
   read datad
   if [ "$datad" == "/" ]
   then
   echo "you can not enter /"
   sleep 1
   clear
   menuItems
   else
   export datad
   if test -d $datad
   then
   tes=${#datad}
   if test $tes -gt 0
   then
   echo "$datad is chosen"
   cd ..
   ./tables.sh
   cd "$d/DBMS"
   cd $datad
   sleep 1
   clear
   menuItems
   
   else
    echo "please enter something"
    sleep 1
    clear
    menuItems
    fi
   else
    echo "database doesnt exist choose another name from list"
    sleep 2
    clear
    menuItems
   fi
   fi
   ;;
3) echo "delete database"
   cd "$d/DBMS"
   ls
   echo "Enter name of database you want to delete"
   read dele
   if [ "$dele" == "/" ]
   then
   echo "you can not enter /"
   sleep 1
   clear
   menuItems
   else
   if test -d $dele
   then
   tes=${#dele}
   if test $tes -gt 0
   then
   rm -r $dele
   echo "$dele is deleted"
   sleep 1
   clear
   menuItems
   else
   echo "please enter something"
   sleep 1
   clear
   menuItems
   fi
   else
   echo "database doesnt exist choose another name from list"
   sleep 2
   clear
   menuItems
   fi
   fi
   ;;
4) break 2
;;
5)cd "$d/DBMS"
  echo "Databases names:"
  #test -d "$d" && ls -l | grep "^d" |cut -d' ' -f12|| echo "Does not exist"
  #ls -l | grep ^d | cut -d" " -f12
  #find . -maxdepth 2 -type d
  ls "$d/DBMS/"

;;
*) echo "this not one of your choices"
   sleep 2
   menuItems
   ;;
esac
done
   
