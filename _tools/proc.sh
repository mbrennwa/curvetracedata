#!/bin/bash

# check input arguments:
if (($# < 13 || $# > 14))
then
	echo "Usage of the proc.sh script:"
	echo ""
	echo "proc.sh <DEVICENAME> <XLABEL> <YLABEL> <XLIMIT> <YLIMIT> <XYLIMIT> <YSCALE> <U0> <I0> <U1> <U2> <I1> <I2> <VBE>"
	echo ""
	echo "where:"
	echo "   DEVICENAME: name of the DUT/device"
	echo "   XLABEL: x-axis label for the curve plots"
	echo "   YLABEL: y-axis label for the curve plots"
	echo "   XLIMIT: x-axis limit for the curve plots"
	echo "   YLIMIT: y-axis limit for the curve plots"
	echo "   XYLIMIT: x*y (power) limit for the curve plots"
	echo "   YSCALE: y-axis scale ('0', 'm','mu', etc.)"
	echo "   U0 and I0: voltage/current value where the device parameters are determined (values in V and A)"
	echo "   U1--U2 and I1--I2: voltage/current range used for curve matching (values in V and A)"
	echo "   VBE (optional): if specified, data is processed assuming a BJT DUT with the specified Vbe voltage (positive value in V)"
	exit 1
fi

if (($# == 14))
then
	BJT=true
	VBE=${14}
else
	BJT=false
fi


DEVICENAME=$1
XLABEL=$2
YLABEL=$3
XLIMIT=$4
YLIMIT=$5
XYLIMIT=$6
YSCALE=$7
U0=$8
I0=$9
U1=${10}
U2=${11}
I1=${12}
I2=${13}

echo "DEVICENAME = $DEVICENAME"
echo "XLABEL = $XLABEL"
echo "YLABEL = $YLABEL"
echo "XLIMIT = $XLIMIT"
echo "YLIMIT = $YLIMIT"
echo "XYLIMIT = $XYLIMIT"
echo "YSCALE = $YSCALE"
echo "U0 = $U0"
echo "I0 = $I0"
echo "U1 = $U1"
echo "U2 = $U2"
echo "I1 = $I1"
echo "I2 = $I2"
if [[ "$BJT" == true ]]; then
	echo "VBE = $VBE"
else
	echo "not a BJT"
fi

# exit 0

# list of ALL data files:
files=$(find data/*.dat -type f | sort)

echo Calculating parameters...
if [[ "$BJT" == true ]]; then
	curveprocess $files --U1I1 [$U0,$I0] --bjtvbe -$VBE --nohello >parameters.csv
else
	curveprocess $files --U1I1 [$U0,$I0] --nohello >parameters.csv
fi

echo Matching curves...
if [[ "$BJT" == true ]]; then
	curvematch $files --U1range [$U1,$U2] --I1range [$I1,$I2] --bjtvbe -$VBE --nohello >curvematch.csv
else
	curvematch $files --U1range [$U1,$U2] --I1range [$I1,$I2] --nohello >curvematch.csv
fi

echo Plotting curves...
# curveplot $files --pairs --savepdf --nodisplay --xlabel "$XLABEL" --ylabel "$YLABEL" --ylimit $YLIMIT --xylimit $XYLIMIT --yscale $YSCALE --fontname Arial
# mv *blue*.pdf plots/

curveplot data/2SJ28_16.dat --savepdf --nodisplay --xlabel "$XLABEL" --ylabel "$YLABEL" --ylimit $YLIMIT --xylimit $XYLIMIT --yscale $YSCALE --fontname Arial

echo Generating HTML files...
csvtotable parameters.csv parameters.html --caption "$DEVICENAME Parameters" --overwrite
csvtotable curvematch.csv curvematch.html --caption "$DEVICENAME Curve Matching" --overwrite
cp ../_tools/index_template.html ./
mv index_template.html index.html
sed -i 's/TEMPLATE/{$DEVICENAME}/g' index.html

echo Generating availability list...
# list of non-NA data files:
rm available_list.txt 2> /dev/null
touch available_list.txt
files=$(find data/*.dat -type f -not -name "*NA*.dat" | sort)
echo 'Available:' > available_list.txt
for f in $files; do echo ${f#*/} >>available_list.txt; done
files=$(find data/*NA*.dat -type f | sort)
echo '' >>available_list.txt
echo 'Not available:' >>available_list.txt
for f in $files; do echo ${f#*/} >>available_list.txt; done

echo Done.