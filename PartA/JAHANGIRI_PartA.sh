#!/bin/bash

#chmod +x Final.tgz
tar zxvf Final.tar
j_origin=`./datecalc -j 2010 01 01`

echo " "
#mkdir temp_files


declare -a Nests

i=0

while IFS=, read -r nest date temp
do 
	i=$((i+1))
	if [ $i -gt 1 ];then
		Nests[$(($i-1))]=$nest
	fi
done <metadata.csv		

echo "Here are the nest numbers according to the metadata.csv file:"
echo " "
echo ${Nests[@]}
echo " "


#echo -e "Julian Date\tTime\tTemperature\tNest\tTreatment" > Nest_Temps.txt 

touch date_temp_r.txt
touch date_temp_f.txt
touch time_temp_r.txt
touch time_temp_f.txt

#echo "Julian Date" > "Julian_${FILEr}"
#echo "Time" > time_temp_r.txt
#echo "Temperature" > temperature_temp_r.txt
#echo "Nest" > nest_temp_r.txt
#echo "Treatment" > treatment_temp_r.txt

echo -e "Julian Date\tTime\tTemperature\tTreatment\tNest" > Nest_Temps.txt	
for nest in "${Nests[@]}"; do

        echo "Working on nest $nest ..."
	
	FILEr=$nest"r.TXT"
	FILEf=$nest"f.TXT"
	if test -f "$FILEr" && test -f "$FILEf"; then
		
		###Processing the r file
		########################
	
		awk '/^Log Data/,/^Debug Dump/' $FILEr | awk '/[0-9]/ {print $1}' > date_temp_r.txt	
		awk '/^Log Data/,/^Debug Dump/' $FILEr | awk '/[0-9]/ {print $2}' > time_temp_r.txt
		awk '/^Log Data/,/^Debug Dump/' $FILEr | awk '/[0-9]/ {print $4}' > temperature_temp_r.txt
		awk '/^Log Data/,/^Debug Dump/' $FILEr | awk '/[0-9]/ {print "Control"}' > treatment_temp_r.txt
		awk -v var=$nest '/^Log Data/,/^Debug Dump/' $FILEr | awk '/[0-9]/ {print var}' var=$nest > nest_temp_r.txt
		

		#awk -F/ '{ echo $(( $(./datecalc -j $col3 $col1 $col2) - $j_origin +1))}' date_temp_r.txt 		
		while IFS=/ read -r col1 col2 col3
		do
		    echo $(( $(./datecalc -j $col3 $col1 $col2) - $j_origin +1)) >> "Julian_${FILEr}"
		    #echo "$(( $(./datecalc -j $col3 $col1 $col2) - $j_origin +1))\t"
   	
		done < date_temp_r.txt
		
		
		paste -d "\t" "Julian_${FILEr}" time_temp_r.txt temperature_temp_r.txt treatment_temp_r.txt nest_temp_r.txt > "Nest_Temps_FILEr.txt"
		#awk -F '\t' -v OFS='\t' '{ $(NF+1) = 10000; print }' infile >outfile
		###Processing the f file
		########################
		#echo "Julian Date" > "Julian_${FILEf}"
		#echo "Time" > time_temp_f.txt
		#echo "Temperature" > temperature_temp_f.txt
		#echo "Nest" > nest_temp_f.txt
		#echo "Treatment" > treatment_temp_f.txt
		
		awk '/^Log Data/,/^Debug Dump/' $FILEf | awk '/[0-9]/ {print $1}' > date_temp_f.txt	
		awk '/^Log Data/,/^Debug Dump/' $FILEf | awk '/[0-9]/ {print $2}' > time_temp_f.txt
		awk '/^Log Data/,/^Debug Dump/' $FILEf | awk '/[0-9]/ {print $4}' > temperature_temp_f.txt
		awk '/^Log Data/,/^Debug Dump/' $FILEf | awk '/[0-9]/ {print "Maternal"}' > treatment_temp_f.txt
		awk -v var=$nest '/^Log Data/,/^Debug Dump/' $FILEf | awk '/[0-9]/ {print var}' var=$nest > nest_temp_f.txt
		

		#awk -F/ '{ echo $(( $(./datecalc -j $col3 $col1 $col2) - $j_origin +1))}' date_temp_r.txt 		
		while IFS=/ read -r col1 col2 col3
		do
		    echo $(( $(./datecalc -j $col3 $col1 $col2) - $j_origin +1)) >> "Julian_${FILEf}"
   	
		done < date_temp_f.txt
			
		paste -d "\t" "Julian_${FILEf}" time_temp_f.txt temperature_temp_f.txt treatment_temp_f.txt nest_temp_f.txt > "Nest_Temps_$FILEf"
		

	
	else
		echo "At least one of nest $nest files is missing"
	fi
done


cat Nest_Temps_* >> Nest_Temps.txt

echo 'Done!'
