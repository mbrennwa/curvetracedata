#!/bin/bash

echo Calculating parameters...
curveprocess data/*.dat --U1I1 [-20,-1.6] --nohello > parameters.csv

echo Matching curves...
curvematch data/*.dat --U1range [-5,-45] --I1range [-0.2,-2.5] --nohello > curvematch.csv

echo Plotting curves...
curveplot data/*.dat --pairs --savepdf --nodisplay --xlabel 'Drain-Source Voltage' --ylabel 'Drain Current' --fontname Arial
mv *blue*.pdf plots/
