#!/bin/bash

files=$(find data/*.dat -type f -not -name "*NA*.dat" | sort)

echo Calculating parameters...
curveprocess $files --U1I1 [300,0.100] --nohello >parameters.csv

echo Matching curves...
curvematch $files --U1range [100,400] --I1range [0.01,0.1] --nohello >curvematch.csv

echo Plotting curves...
curveplot $files --pairs --savepdf --nodisplay --xlabel 'Anode-Cathode Voltage' --ylabel 'Anode Current' --ylimit 0.10 --xylimit 50 --yscale 'm' --fontname Arial --width 15
mv *blue*.pdf plots/

echo Generating HTML files...
csvtotable parameters.csv parameters.html --caption "300B Parameters" --overwrite
csvtotable curvematch.csv curvematch.html --caption "300B Curve Matching" --overwrite
cp ../_tools/index_template.html ./
mv index_template.html index.html
sed -i 's/TEMPLATE/300B/g' index.html

echo Done.
