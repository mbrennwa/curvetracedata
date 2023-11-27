#!/bin/bash

files=$(find data/*.dat -type f -not -name "*NA*.dat" | sort)

echo Calculating parameters...
curveprocess $files --U1I1 [25,1.8] --nohello >parameters.csv

echo Matching curves...
curvematch $files --U1range [5,45] --I1range [0.2,3.5] --nohello >curvematch.csv

echo Plotting curves...
curveplot $files --pairs --savepdf --nodisplay --xlabel 'Drain-Source Voltage' --ylabel 'Drain Current' --xylimit 100 --fontname Arial
mv *blue*.pdf plots/

echo Generating HTML files...
csvtotable parameters.csv parameters.html --caption "THF51 Parameters" --overwrite
csvtotable curvematch.csv curvematch.html --caption "THF51 Curve Matching" --overwrite
cp ../_tools/index_template.html ./
mv index_template.html index.html
sed -i 's/TEMPLATE/THF51/g' index.html

echo Done.
