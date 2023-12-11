#!/bin/bash

files=$(find data/*.dat -type f -not -name "*NA*.dat" | sort)

echo Calculating parameters...
curveprocess $files --U1I1 [24,1] --nohello >parameters.csv

echo Matching curves...
curvematch $files --U1range [5,26] --I1range [0,5] --nohello >curvematch.csv

echo Plotting curves...
curveplot $files --pairs --savepdf --nodisplay --xlabel 'Drain-Source Voltage' --ylabel 'Drain Current' --fontname Arial
mv *blue*.pdf plots/

echo Generating HTML files...
csvtotable parameters.csv parameters.html --caption "FQA16N25C Parameters" --overwrite
csvtotable curvematch.csv curvematch.html --caption "FQA16N25C Curve Matching" --overwrite
cp ../_tools/index_template.html ./
mv index_template.html index.html
sed -i 's/TEMPLATE/FQA16N25C/g' index.html

echo Done.
