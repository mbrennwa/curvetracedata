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

echo Done.
