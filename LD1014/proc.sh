#!/bin/bash

echo Calculating parameters...
curveprocess data/*.dat --U1I1 [1.5:1.5,1.5:2.5,4] --nohello > parameters.csv


echo Matching curves...
curvematch data/*.dat --nohello > curvematch.csv

echo Plotting curves...
curveplot data/*_{200..999}.dat --pairs --maxdeltaU2 0.03 --nodisplay --savepdf --xlabel 'Drain-Source Voltage' --ylabel 'Drain Current' --ylimit 3.5 --xlimit 3.0 --fontname Arial
mv *blue*.pdf plots/

echo Generating HTML files...
csvtotable parameters.csv parameters.html --caption "LD1014 Parameters" --overwrite
csvtotable curvematch.csv curvematch.html --caption "LD1014 Curve Matching" --overwrite
cp ../_tools/index_template.html ./
mv index_template.html index.html
sed -i 's/TEMPLATE/LD1014/g' index.html

echo Generating availability list...
# list of non-NA data files:
rm available_list.txt 2> /dev/null
touch available_list.txt
files=$(find data/*.dat -type f -not -name "*NA*.dat" | sort)
echo 'Available:' > available_list.txt
for f in $files; do echo ${f#*/} >>available_list.txt; done
files=$(find data/*NA*.dat -type f | sort)
echo '' >>available_list.txt
echo 'Not available:' >>available_list.txt
for f in $files; do echo ${f#*/} >>available_list.txt; done

echo Done.
