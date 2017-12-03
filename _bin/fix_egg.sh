#!/bin/sh
# the egg mouse is super sensitive, even with the
# accel knobs turned to 0 in the gui
xinput --set-prop "HID 04d9:2082" "libinput Accel Speed" -0.9
#xinput --set-prop "HID 04d9:2082" "Device Accel Profile" 0
#xinput --set-prop "HID 04d9:2082" "Device Accel Velocity Scaling"  1
#xinput --set-prop "HID 04d9:2082" "Device Accel Constant Deceleration" 4
