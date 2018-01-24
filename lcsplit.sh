#!/bin/bash

##### LCSPLIT is a part of LCSPANS (LightCurve SPlit and ANalyse Script) project.(2018) Burak Ulas ####
##### https://github.com/burakulas/lcsplit ####
clear

echo -e "\033[1;31m  _    ___  ___ ___ _    ___ _____ \033[0m"
echo -e "\033[1;31m | |  / __|/ __| _ \ |  |_ _|_   _|\033[0m"
echo -e "\033[1;31m | |_| (__ \__ \  _/ |__ | |  | |  \033[0m"
echo -e "\033[1;31m |____\___||___/_| |____|___| |_|  \033[0m"
echo -e "\033[1;31m ________________________________\033[0m"
echo " "

ls > lslist.tpl

ls1=$(cat lslist.tpl | awk '{if ($1 == "work") print "1";}')
if [[ $ls1 -eq  1 ]]; then
      read -r -p $'Program detected the \e[0;32mwork\e[0m folder from previous run. It will be removed. \e[1;33mContinue? [Y/n] \e[0m: ' che1
      case $che1 in
    	 [yY][eE][sS]|[yY])
 	 echo "Yes"
 	 rm -rf work
 	 ;;
    	    [nN][oO]|[nN]|*)
 	 echo "No"
 	 exit 1    ;;
    	    *)
 	 echo "Invalid input..."
 	 exit 1
 	 ;;
       esac
fi

ls3=$(cat lslist.tpl | awk '{if ($1 == "LightCurves") print "3";}')
if [[ $ls3 -eq  3 ]]; then
      read -r -p $'Program detected the \e[0;32mLightCurves\e[0m folder from previous run. It will be removed. \e[1;33mContinue? [Y/n] \e[0m: ' che3
      case $che3 in
         [yY][eE][sS]|[yY])
         echo "Yes"
         rm -rf LightCurves
         ;;
            [nN][oO]|[nN]|*)
         echo "No"
         exit 1    ;;
            *)
         echo "Invalid input..."
         exit 1
         ;;
       esac
fi

read -p $'\e[1;33mName of the data file\e[0m : ' dfi
if [ ! -f $dfi ]; then
    echo -e "\033[0;31mFile not found!\033[0m"
    echo " "
    exit 1
fi
rm *.tpl

echo Checking data...
fir(){
colv1=$(awk '{print NF; exit}' $dfi)
cp $dfi dfi.tpl
awk '$1 ~ /^[0-9]+([.][0-9]+)?$/' dfi.tpl > temp1.tpl
awk '!/\NULL/' temp1.tpl > temp2.tpl
awk '!/\null/' temp2.tpl > temp3.tpl
awk '!/\inf/' temp3.tpl > temp4.tpl
awk '!/\Inf/' temp4.tpl > temp5.tpl
awk '!/\#/' temp5.tpl > temp6.tpl
}
export -f fir

fir_sp0(){
fir&
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
}
export -f fir_sp0

fir_sp0

cp temp6.tpl df.tpl
colv2=$(awk '{print NF; exit}' df.tpl)

read -p $'\e[1;33mColumn number of the time data in the file\e[0m : ' colt


re='^[0-9]+([.][0-9]+)?$'
if ! [[ $colt =~ $re ]] ; then
   echo -e "\033[0;31mValue is not valid.\033[0m" >&2
   echo " "
   rm *.tpl
   exit 1
fi


if [ $colt -gt $colv2 ] ; then
   echo -e "\033[0;31mThe data file contains $colv2 columns. Check your file and re-run the script.\033[0m" >&2
   echo " "
   rm *.tpl
   exit 1
fi

if [ $colt -le 0 ] ; then
   echo -e "\033[0;31mValue is not valid.\033[0m" >&2
   rm *.tpl
   echo " "
   exit 1
fi

read -p $'\e[1;33mColumn number of the flux data in the file\e[0m : ' colf

re='^[0-9]+([.][0-9]+)?$'
if ! [[ $colf =~ $re ]] ; then
   echo -e "\033[0;31mValue is not valid.\033[0m" >&2
   echo " "
   rm *.tpl
   exit 1
fi


if [ $colf -gt $colv2 ] ; then
   echo -e "\033[0;31mThe data file contains $colv2 columns. Check your file and re-run the script.\033[0m" >&2
   echo " "
   rm *.tpl
   exit 1
fi

if [ $colf -le 0 ] ; then
   echo -e "\033[0;31mValue is not valid.\033[0m" >&2
   echo " "
   rm *.tpl
   exit 1
fi


read -p $'\e[1;33mEnter the period\e[0m : ' p
re='^[0-9]+([.][0-9]+)?$'
if ! [[ $p =~ $re ]] ; then
   echo -e "\033[0;31mValue is not valid.\033[0m" >&2
   echo " "
   rm *.tpl
   exit 1
fi


to=$(awk -v colt="$colt" 'FNR == 1 {print $colt}' df.tpl)

echo " "
echo Preparing the light curve for splitting...
cp df.tpl tabl.tpl
sp0(){

awk -v a="$to" -v colt="$colt" -v colf="$colf" '{print $colt,$colf,a}' tabl.tpl > inx.tpl
awk -v b="$p" '{print $1,$2,$3,b}' inx.tpl > in2x.tpl
awk '{print $1,$2,int(($1-$3)/$4)}' in2x.tpl > alltocodepre.tpl
awk '{printf "%-0s %-0s %06d\n",$1,$2,$3}' alltocodepre.tpl > alltocode.tpl
}
export -f sp0

sp_sp0(){
sp0 &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
}

export -f sp_sp0
sp_sp0



echo " "
echo  Sorting the light curve...

sort_1(){
sort -k1 alltocode.tpl -o dfso.tpl
mv dfso.tpl alltocode.tpl
}
export -f sort_1

sort_sp0(){
sort_1&
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
}

export -f sort_sp0

sort_sp0


awk '{printf"%-10s %-8s %-0s\n",$1,$2,$3}' alltocode.tpl >  allcodec2.tpl

echo -e "\033[1;31mSplitting process starts from the first datapoint.\033[0m"
echo Splitting started...

split_1(){
awk '{printf"%-0s,%-0s,%-0s\n",$1,$2,$3}' allcodec2.tpl > allcodecom.tpl
awk -F, '{print > "data"$3}' allcodecom.tpl

}

export -f split_1
mkdir work
don(){
split_1
ls data* > datlist.tpl
datlist=$(cat datlist.tpl | wc -l)
echo -e Light curve is split to "\033[1;34m$datlist\033[0m" sub-light curves.

}
export -f don

sp_sp(){
don &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
}
export -f sp_sp

sp_sp

echo " "
read -p $'\e[1;33mEnter the desired min. number of datapoints in each sub-light curve file\e[0m: ' mnd
re='^[0-9]+([.][0-9]+)?$'
if ! [[ $mnd =~ $re ]] ; then
   echo -e "\033[0;31mValue is not valid.\033[0m" >&2
   echo " "
   rm *.tpl
   rm data*
   rm -rf work
   exit 1
fi

echo -e "\033[1;31mSub-light curves with smaller than\033[0m" "\033[1;34m$mnd\033[0m" "\033[1;31mdatapoints will be ignored.\033[0m"


if_1(){
ls data* > datlist.tpl
datlist=$(cat datlist.tpl | wc -l)
for i in data*;do
    kar=$(cat $i | wc -l)
    if [[ $mnd -le kar ]]
       then
            printf "$i\n" >> templist2a.tpl
	    tmpla=$(cat templist2a.tpl | wc -l) 
	   continue
       else
            	printf "$i\n" > templistb$i.tpl
            	cat templistb* > templist2b.tpl
                tmplb=$(cat templist2b.tpl | wc -l)
		if [[ $tmplb = $datlist ]]
    			then
				printf "$i\n" >> templist2b2.tpl
    			else
				printf "$i\n" >> templistc.tpl
		fi
    fi
done
}

export -f if_1

if_1_sp(){
if_1 &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
}
export -f if_1_sp

if_1_sp

if [ ! -f templist2b2.tpl ]
	then
		if [ ! -f templistc.tpl ]
                        then
                                echo -e "\033[1;34m0\033[0m" sub-light curves are ignored.
                                datlist=$(cat datlist.tpl | wc -l)
				echo -e Proceeding with "\033[1;34m$datlist\033[0m" sub-light curves...
			else
                		iglist=$(cat templistc.tpl | wc -l)
                		tmpla=$(cat templist2a.tpl | wc -l)
				xargs rm -r < templistc.tpl
                		echo -e "\033[1;34m$iglist\033[0m" sub-light curves are ignored.
                		echo -e Proceeding with "\033[1;34m$tmpla\033[0m" sub-light curves...
		fi
	else
                rm -rf work
		rm dat*
		rm *.tpl
		echo " "
                echo None of the sub-light curves contain the desired min. number of datapoints. All curves are ignored.
                echo Re-run the script and enter smaller number of datapoints in related prompt or check your period value.
                echo -e "\033[0;31mProgram stopped.\033[0m"
                echo " "
		exit 1
fi

for_1(){
for i in data*;do
	cat $i > dt.tpl 2> /dev/null
	sed -i 's/,/ /g' dt.tpl
	awk '{printf"%-0s %-0s\n",$1,$2}' dt.tpl >  $i.slc
	rm dt.tpl
done
}

export -f for_1

for_1_sp(){
for_1 &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
}

export -f for_1_sp

for_1_sp

mkdir LightCurves
mv *.slc ./LightCurves
mv dat* ./work
mv *.tpl ./work
rm -rf work
echo " "
echo -e Splitting finished. Sub-light curves are extracted to "\e[0;32mLightCurves\e[0m" folder.
echo " "
