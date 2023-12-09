#!/bin/bash

files=$(find data/*.dat -type f -not -name "*NA*.dat" | sort)

echo Calculating parameters...
curveprocess $files --U1I1 [15,0.5] --bjtvbe 0.65 --nohello >parameters.csv

echo Matching curves...
curvematch $files --U1range [3,20] --I1range [0.1,2.0] --bjtvbe 0.65 --nohello >curvematch.csv

echo Plotting curves...
curveplot $files --bjtvbe 0.65 --cscale m --pairs --savepdf --nodisplay --xlabel 'Collector-Emitter Voltage' --ylabel 'Collector Current' --xylimit 50 --fontname Arial
mv *blue*.pdf plots/

echo Generating HTML files...
csvtotable parameters.csv parameters.html --caption "MJL21194 Parameters" --overwrite
csvtotable curvematch.csv curvematch.html --caption "MJL21194 Curve Matching" --overwrite
cp ../_tools/index_template.html ./
mv index_template.html index.html
sed -i 's/TEMPLATE/MJL21194/g' index.html

echo Done.
