#!/bin/bash

curvematch data/*.dat --U1range [-5,-26] --I1range [0,-5] > curvematch.csv
curveplot data/*.dat --pairs --savepdf --nodisplay --xlabel 'Drain-Source Voltage' --ylabel 'Drain Current'
mv *blue*.pdf plots/
