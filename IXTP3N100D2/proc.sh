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

../_tools/proc.sh 'IXTP3N100D2' 'GATE-SOURCE VOLTAGE' 'DRAIN CURRENT' 500 0.1 5 m 10 6 440 0.02 0 500 0.0 0.1 0
