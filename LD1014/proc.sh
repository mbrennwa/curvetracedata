#!/bin/bash

echo Calculating parameters...
curveprocess data/*.dat --U1I1 [1.5:1.5,1.5:2.5,4] --nohello > parameters.csv

echo Matching curves...
curvematch data/*.dat --nohello > curvematch.csv

echo Plotting curves...
curveplot data/*_{200..999}.dat --pairs --maxdeltaU2 0.03 --nodisplay --savepdf --xlabel 'Drain-Source Voltage' --ylabel 'Drain Current' --ylimit 3.5 --xlimit 3.0 --fontname Arial
mv *blue*.pdf plots/
