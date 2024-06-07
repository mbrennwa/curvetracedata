#!/bin/bash

# check input arguments:
if (($# < 16 || $# > 16))
then
	echo "Usage of the proc.sh script:"
	echo ""
	echo "proc.sh <DEVICENAME> <XLABEL> <YLABEL> <XLIMIT> <YLIMIT> <XYLIMIT> <YSCALE> <WIDTH> <HEIGHT> <U0> <I0> <U1> <U2> <I1> <I2> <VBE>"
	echo ""
	echo "where:"
	echo "   DEVICENAME: name of the DUT/device"
	echo "   XLABEL: x-axis label for the curve plots"
	echo "   YLABEL: y-axis label for the curve plots"
	echo "   XLIMIT: x-axis limit for the curve plots"
	echo "   YLIMIT: y-axis limit for the curve plots"
	echo "   XYLIMIT: x*y (power) limit for the curve plots"
	echo "   YSCALE: y-axis scale ('0', 'm','mu', etc.)"
	echo "   WIDTH: plot width"
	echo "   HEIGHT: plot height"
	echo "   U0 and I0: voltage/current value where the device parameters are determined (values in V and A)"
	echo "   U1--U2 and I1--I2: voltage/current range used for curve matching (values in V and A)"
	echo "   VBE: if VBE > 0 data is processed assuming a BJT DUT with the specified Vbe voltage (value in V)"
	exit 1
fi

DEVICENAME=$1
XLABEL=$2
YLABEL=$3
XLIMIT=$4
YLIMIT=$5
XYLIMIT=$6
YSCALE=$7
WIDTH=$8
HEIGHT=$9
U0=${10}
I0=${11}
U1=${12}
U2=${13}
I1=${14}
I2=${15}
VBE=${16}

### FONTNAME="Adventure Island"
### FONTNAME="Comodo Free"

### for use of National Park font, use the fontname.py tool and change the font name to NationalPark
### https://github.com/chrissimpkins/fontname.py
### FONTNAME="NationalPark"

### FONTNAME="AVHershey Simplex"

FONTNAME="Arial"


### FONTNAME="SF Pro Rounded"

### FONTNAME="Open Runde"

### FONTNAME="Polly Rounded"

### FONTNAME="Cake Sans"

### FONTNAME="Visby Round CF"

echo "DEVICENAME = $DEVICENAME"
echo "XLABEL = $XLABEL"
echo "YLABEL = $YLABEL"
echo "XLIMIT = $XLIMIT"
echo "YLIMIT = $YLIMIT"
echo "XYLIMIT = $XYLIMIT"
echo "YSCALE = $YSCALE"
echo "WIDTH = $WIDTH"
echo "HEIGHT = $HEIGHT"
echo "U0 = $U0"
echo "I0 = $I0"
echo "U1 = $U1"
echo "U2 = $U2"
echo "I1 = $I1"
echo "I2 = $I2"
if [[ $VBE > 0 ]]; then
	echo "VBE = $VBE"
else
	echo "not a BJT"
fi

# exit 0

# list of ALL data files:
files=$(find data/*.dat -type f | sort)

echo Calculating parameters...
if [[ $VBE > 0 ]]; then
	curveprocess $files --U1I1 [$U0,$I0] --bjtvbe -$VBE --nohello >parameters.csv
else
	curveprocess $files --U1I1 [$U0,$I0] --nohello >parameters.csv
fi

echo Matching curves...
if [[ $VBE > 0 ]]; then
	curvematch $files --U1range [$U1,$U2] --I1range [$I1,$I2] --bjtvbe -$VBE --nohello >curvematch.csv
else
	curvematch $files --U1range [$U1,$U2] --I1range [$I1,$I2] --nohello >curvematch.csv
fi

echo Plotting curves...

cd plots
curveplot ../$files --pairs --savepdf --nodisplay --xlabel "$XLABEL" --ylabel "$YLABEL" --xlimit $XLIMIT --ylimit $YLIMIT --xylimit $XYLIMIT --yscale $YSCALE --width $WIDTH --height $HEIGHT --fontname "$FONTNAME"
### mv *blue*.pdf plots/
cd ..


echo Generating HTML files...
csvtotable parameters.csv parameters.html --caption "$DEVICENAME Parameters" --overwrite
csvtotable curvematch.csv curvematch.html --caption "$DEVICENAME Curve Matching" --overwrite
cp ../_tools/index_template.html ./
mv index_template.html index.html
sed -i "s%TEMPLATE%$DEVICENAME%g" index.html
DEVICEDIR=$(basename $PWD)
sed -i "s/TMPLATPLOTS/$DEVICEDIR/g" index.html

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
