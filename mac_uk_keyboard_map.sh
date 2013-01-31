#!/bin/bash

cp /etc/X11/xinit/xinitrc{,.bak}
echo "Changes applied:"

cat > /etc/X11/Xmodmap << EOF
keycode 51 = backslash bar
keycode 11 = 2 at EuroSign
keycode 48 = apostrophe quotedbl
keycode 12 = 3 sterling numbersign
keycode 13 = 4 dollar cent
keycode 94 = grave asciitilde grave asciitilde dead_grave dead_horn
keycode 49 = section plusminus section plusminus section plusminus

! Left Command key as mode switch (to get #, €, etc.)
keycode 115 = Mode_switch
EOF
ls -al /etc/X11/Xmodmap

if [ `grep -c Xmodmap /etc/X11/xinit/xinitrc` -lt "2" ]
then
cat >> /etc/X11/xinit/xinitrc << EOF

# Apply custom Xmodmap keyboard mapping for Macbook UK keyboard
. /etc/X11/Xmodmap
EOF
ls -al /etc/X11/xinit/xinitrc
fi

xmodmap /etc/X11/Xmodmap
echo "Please reboot to ensure changes are permanently applied"
