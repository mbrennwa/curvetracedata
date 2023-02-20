#!/bin/bash

curveplot data/*.dat --pairs --xlabel 'Drain-Source Voltage' --ylabel 'Drain Current' --savepdf --nodisplay
mv *.pdf plots/

echo -e '\n***** Moved PDF files to plots directory'
