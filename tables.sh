#!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob
#+([a-zA-Z])
#+([0-9]) )
function choices(){
echo "1) create table"
echo "2) choose table"
echo "3) insert in table"
echo "4) modify table"
echo "5) delete table"
echo "6) show tables"
echo "7) exit to database menu"
}
function modd(){
echo "1) edit cell"
echo "2) delete record"
echo "3) exit to table menu"
}
function inst(){
while true
   do
   echo "enter data type(str,int)" 
   read data
   if [ "$data" == "int" ]
   then
   echo -n $column":"$data":">>$namet
   let count=$count+1
   break
   elif [ "$data" == "str" ]
   then
   echo -n $column":"$data":">>$namet
   let count=$count+1 
   break
   else 
   echo "you can enter str and int only"
   fi
   done
}
function instp(){
while true
   do
   echo "enter primary key type(str,int)" 
   read primarytype
   if [ "$primarytype" == "int" ]
   then
   echo -n $info":"$primarytype":">>$namet
   break
   elif [ "$primarytype" == "str" ]
   then
   echo -n $info":"$primarytype":">>$namet
   break
   else 
   echo "you can enter str and int only"
   fi
   done
}
clear
select choice in "create table" "choose table" "insert in table" "modify table" "delete table" "show tables" "exit to database menu"  
do
case $REPLY in
1)
   while true
   do
   echo "enter table name"
   read namet
   if test -f $namet
   then
   echo "table name exsist"
   else
   if [[ $namet =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
   then
   cd "$d/DBMS/$datad"
   touch $namet
   break
   else
   echo "Invalid name"
   fi
   fi
   done
   while true
   do
   echo "enter number of colums"
   read num
   if [[ $num =~ ^[0-9]+$ ]]
   then
   
   if test $num -gt 1
   then
   echo -n $num":">>$namet
   break
   else
   echo "number should be more than one"
   fi
   else
   echo "you should enter numbers only"
   fi
   done
   ###echo ""
   while true
   do
   echo "enter name primary key column"
   read info
   if [ "$info" == "int" ]
   then
   echo "column name can not be int"
   elif [ "$info" == "str" ]
   then
   echo "column name can not be str"
   else
   if [[ $info =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
   then
   instp
   break
   else
   echo "column name can not be this format"
   fi
   fi
   done
   typeset -i count=1
   typeset -i fofo=0
   while [ $count -lt $num ]
   do
   let count=$count+1
   echo "enter column$count name"
   let count=$count-1
   read column
   if [ "$column" == "int" ]
   then
   echo "column name can not be int"
   elif [ "$column" == "str" ]
   then
   echo "column name can not be str"
   else
   if [[ $column =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
   then
   linecutting=`head -1 $namet`
   iffs=$IFS
   IFS=":"
   for zz in $linecutting
   do
   ##echo "$zz"
   if [ "$zz" == "$column" ]
   then
    fofo=1
   fi
   IFS=$iffs
   done
   if test $fofo -eq 0
   then
   inst
   else
    echo "you entered repeated column name"
   fi
   fofo=0
   else
   echo "invalid column name"
   fi
   fi
   done
   printf "\n">>$namet
   #echo " "
   clear
   choices

   ;;
3)
   inins=""
   if [ "$ctab" == "" ]
   then
   echo "you should choose a table first (choice 2 in menu)"
   else
   clear
   echo "you are now in $ctab table"
   typeset -i fields=3
   typeset -i ccname=2
   typeset -i kflag=0
   typeset -i loop=0
   size=`head -1 $ctab| cut -d: -f1`
   #echo "">>$ctab
   while [ $loop -lt $size ]
   do
   ccon=`head -1 $ctab | cut -d: -f"$ccname"`
   echo "enter data of $ccon column"
   read respect
   if [ "$respect" != ":" ]
   then
   trespect=`head -1 $ctab | cut -d: -f$fields`
   if test $loop -eq 0
   then
   pke=`tail -n +2 $ctab |cut -d: -f1`
   for ke in $pke
   do
   if [ "$ke" == "$respect" ]
   then
   echo "you can not repeat primary key"
   kflag=1
   fi
   done
   if test $kflag -eq 0
   then
   tess=${#respect}
   if test $tess -gt 0
   then
   if [[ $respect =~ ^-?[0-9]+$ ]]
   then
   if [ "$trespect" ==  "int" ]
   then
   #echo -n $respect":">>$ctab
   inins+=$respect
   inins+=":"
   let loop=$loop+1
   let fields=$fields+2 
   let ccname=$ccname+2
   else
   echo "you can not enter input diffrent from column type"
   fi
   elif [[ $respect =~ ^[0-9]*[a-zA-Z]*[0-9]*$ ]]
   then
   if [ "$trespect" == "str" ]
   then
   #echo -n $respect":">>$ctab
   inins+=$respect
   inins+=":"
   let loop=$loop+1
   let fields=$fields+2
   let ccname=$ccname+2
   else
   echo "you can not enter input diffrent from column type"
   fi
   fi
   else
   echo "enter something"
   fi 
   fi # end of kflag
   else
   if [ "$respect" == '' ]
   then
   #echo -n $respect":">>$ctab
   inins+=$respect
   inins+=":"
   let loop=$loop+1
   let fields=$fields+2 
   let ccname=$ccname+2
   fi
   if [[ $respect =~ ^-?[0-9]+$ ]]
   then
    if [ "$trespect" ==  "int" ]
    then
    #echo "you enerted this ifffffffffff"
    #echo -n $respect":">>$ctab
    inins+=$respect
    inins+=":"
    let loop=$loop+1
    let fields=$fields+2 
    let ccname=$ccname+2
    fi #end of small if
    elif [[ $respect =~ ^-?!?@?#?[0-9]*[a-zA-z]*[0-9]*[@|.]*[a-zA-z]+[@|.]*[a-zA-z]*$ ]]
    then
    if [ "$trespect" == "str" ]
    then
    #echo "u entered string"
    #echo -n $respect":">>$ctab
    inins+=$respect
    inins+=":"
    let loop=$loop+1
    let fields=$fields+2
    let ccname=$ccname+2
    else
    echo "you can not enter input diffrent from column type"
    fi
    
    fi #end of big if (int)
    fi #end of biggest if key
    kflag=0
    else
    echo "you can not enter :"
    fi
    done
    echo $inins>>$ctab
   clear
   choices
   fi
 ;;
7)break 2
   ;;
5)cd "$d/DBMS/$datad"
  ls -p | grep -v /
  echo "Enter name of database you want to delete"
  read della
  if [[ $della =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
  then
  if test -f $della
  then
  lee=${#della}
  if test $lee -gt 0
  then
  rm $della
  echo "$della is deleted"
  sleep 1
  clear
  choices
  else
  echo "please enter anything"
  sleep 2
  clear
  choices
  fi
  else
  echo table doesnt exist choose another name from list
  sleep 2
  clear
  choices
  fi
  else
  echo "Invalid name"
  fi
;;
6)cd "$d/DBMS/$datad"
  echo "tables names: "
  ls -p | grep -v /
;;
2)cd "$d/DBMS/$datad"
  echo "choose table"
  read ctab
  if test -f $ctab
  then
  le=${#ctab}
  if test $le -gt 0
  then
  echo "$ctab is chosen"
  sleep 1
  clear
  choices
  else
  echo "please enter something"
  sleep 1
  clear
  choices
  fi
  else
  echo "table doesnt exist choose another name from list"
  sleep 2
  clear
  choices
  fi
;;
4)if test "$ctab" = ""
  then
  echo "you should choose a table first (choice 2 in menu)"
  else
  typeset -i infin=`cat $ctab |wc -l`
  clear
  if test $infin -lt 1
  then
  echo "table is empty"
  sleep 1
  clear
  choices
  else
  echo "you are now in $ctab table"
  select choi in "edit cell" "delete record" "exit to table menu" 
  do
  case $REPLY in
  1)
    typeset -i flaggg=0
    modfcut=`tail -n +2 $ctab | cut -d: -f1`
    typeset -i modflag=0
    while true
    do
    echo "Enter record primary key"
    read columnid
    typeset -i modcoun=1
    for ii in $modfcut
    do
    #let modcoun=$modcoun+1
    if [ "$ii" ==  "$columnid" ]
    then
     #echo "hello"
     modflag=1
     break 2
    fi
    done
    #modcoun=0
    
    if test $modflag -eq 0
    then
    echo "primary key not found"
    flaggg=1
    sleep 1
    clear
    modd
    break
    fi
    modflag=0
    done
   #######################################################3
    if test $flaggg -eq 0
    then
    typeset -i flfl=0
    while true
    do
    onel=`head -1 $ctab`
    echo "Enter Column Name"
    read colnameee 
    typeset -i fcount=0  
    regex='^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$'
    if [[ $colnameee =~ $regex ]]
    then
    iffss=$IFS
    IFS=":"
    for cooln in $onel
    do
    let fcount=$fcount+1
    if [ "$cooln" ==  "$colnameee" ]
    then
    flfl=1
    break 2
    fi
    IFS=$iffss
    done
    fi 
    if test $flfl -eq 0
    then
    echo "wrong name or column not found"
    fi
    flfl=0
    done
    typeset -i tval=$fcount+1
    let fcount=$fcount/2
    ###########################################
    tyval=`head -1 $ctab|cut -d: -f$tval`
    while true
    do
    echo "enter the new value"
    read newv
    if [ "$tyval" ==  "int" ]
    then 
    #echo "entered int "
    if [[ $newv =~ ^-?[0-9]+$ ]]
    then
    #echo "u entered int"
    break
    fi #end of small if
    else
    if [ "$tyval" == "str" ]
    then
   # echo "entered str"
    if [[ $newv =~ ^-?!?@?#?[0-9]*[a-zA-z]+[0-9]*[@|.]*[a-zA-z]+[@|.]*[a-zA-z]*$ ]]
    then
    #echo "u entered string"
    break
    fi
    fi
    fi #end of big if (int)
    echo "you can not enter input diffrent from column type"
    done
    if test $fcount -eq 1
    then
    echo "you can not edit in primary key column"
    else
    pat=`whoami`
    touch /home/$pat/Desktop/.tmperoary
	awk -F: -v pkvalue=$columnid -v cellvalue=$newv -v colnum=$fcount '{OFS=FS;if($1==pkvalue){$colnum=cellvalue};print $0}' $ctab > /home/$pat/Desktop/.tmperoary 
    #cat /home/$pat/Desktop/.tmperoary > $ctab
    #rm /home/$pat/Desktop/.tmperoary
    rm $ctab
    mv /home/$pat/Desktop/.tmperoary $ctab
    echo "Cell is edited"
    sleep 1
    clear
    modd
    fi
    else
    clear
    modd
    fi
    ;;
  2)modfcut=`tail -n +2 $ctab | cut -d: -f1`
    typeset -i modflag=0
    echo "Enter record primary key"
    read columnid
    typeset -i modcoun=1
    for ii in $modfcut
    do
    let modcoun=$modcoun+1
    if [ "$ii" ==  "$columnid" ]
    then
     sed -i "$modcoun d" $ctab
     echo "record is deleted"
     modflag=1
     break
    fi
    done
    modcoun=0
    if test $modflag -eq 0
    then
    echo "primary key not found"
    fi
    modflag=0
    sleep 1
    clear
    modd
 
   ;;
  3)clear
    choices
    break
   ;;
  *) echo "Invalid choice"
     sleep 1
     modd
   ;;
  esac
  done
  fi
  fi
;;
*) echo "Invalid choice"
   sleep 1
   choices 
   ;;
esac
done
