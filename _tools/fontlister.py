#!/usr/bin/env python3

from matplotlib import font_manager
for f in sorted(font_manager.get_font_names()):
    print(f)
