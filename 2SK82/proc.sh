#!/bin/bash

files=$(find data/*.dat -type f -not -name "*NA*.dat" | sort)

echo Calculating parameters...
curveprocess $files --U1I1 [20,1.6] --nohello >parameters.csv

echo Matching curves...
curvematch $files --U1range [5,45] --I1range [0.2,2.5] --nohello >curvematch.csv

echo Plotting curves...
curveplot $files --pairs --savepdf --nodisplay --xlabel 'Drain-Source Voltage' --ylabel 'Drain Current' --xylimit 60 --fontname Arial
mv *blue*.pdf plots/

echo Generating HTML files...
csvtotable parameters.csv parameters.html --caption "2SK82 Parameters" --overwrite
csvtotable curvematch.csv curvematch.html --caption "2SK82 Curve Matching" --overwrite
cp ../_tools/index_template.html ./
mv index_template.html index.html
sed -i 's/TEMPLATE/2SK82/g' index.html

echo Done.
