#!/bin/bash

# DEVICENAME: name of the DUT/device"
# XLABEL: x-axis label for the curve plots"
# YLABEL: y-axis label for the curve plots"
# XLIMIT: x-axis limit for the curve plots"
# YLIMIT: y-axis limit for the curve plots"
# XYLIMIT: x*y (power) limit for the curve plots"
# YSCALE: y-axis scale ('0', 'm','mu', etc.)"
# WIDTH: plot width"
# HEIGHT: plot height"
# U0 and I0: voltage/current value where the device parameters are determined (values in V and A)"
# U1--U2 and I1--I2: voltage/current range used for curve matching (values in V and A)"
# VBE: if VBE > 0 data is processed assuming a BJT DUT with the specified Vbe voltage (value in V)"

### ../_tools/proc.sh 801A 'Anode-Cathode Voltage' 'Anode Current' 600 0.028 20 m 14 6 400 0.02 50 600 0.001 0.03 0



## ../_tools/proc.sh 2SJ28 'Drain-Source Voltage' 'Drain Current' -60 -5 60 mu -20 -1.6 -5 -45 -0.2 -2.5 0


../_tools/proc.sh 2SJ28 'Drain-Source Voltage' 'Drain Current' -60 -5 60 0 10 6 -20 -1.6 -5 -45 -0.2 -2.5 0

