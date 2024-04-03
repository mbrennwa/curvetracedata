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

../_tools/proc.sh SJEP120R100 'Drain-Source Voltage' 'Drain Current' 20 2.0 20 0 10 6 12 0.8 0 16 0.0 2.0 0
