#!/bin/bash

files=$(find data/*.dat -type f -not -name "*NA*.dat" | sort)

echo Calculating parameters...
curveprocess $files --U1I1 [-24,-1] --nohello >parameters.csv

echo Matching curves...
curvematch $files --U1range [-5,-26] --I1range [0,-5] --nohello >curvematch.csv

echo Plotting curves...
curveplot $files --pairs --savepdf --nodisplay --xlabel 'Drain-Source Voltage' --ylabel 'Drain Current' --fontname Arial
mv *blue*.pdf plots/

echo Generating HTML files...
csvtotable parameters.csv parameters.html --caption "FQA12P20 Parameters" --overwrite
csvtotable curvematch.csv curvematch.html --caption "FQA12P20 Curve Matching" --overwrite
cp ../_tools/index_template.html ./
mv index_template.html index.html
sed -i 's/TEMPLATE/FQA12P20/g' index.html

echo Done.
