#!/bin/sh

if [ `dd if=/dev/mmcblk0 bs=512 skip=1024 count=1 | grep -c "HW CONFIG"` == 1 ]; then
	PCB=`ntx_hwconfig -s -p /dev/mmcblk0 PCB`
	RES=`ntx_hwconfig -s -p /dev/mmcblk0 DisplayResolution`

elif [ -e /dev/mmcblk0p6 ] && [ `dd if=/dev/mmcblk0p6 bs=512 skip=1 count=1 | grep -c "HW CONFIG"` == 1 ]; then
	PCB=`ntx_hwconfig -S 1 -p /dev/mmcblk0p6 PCB`
	BRAND=$( ntx_hwconfig -S 1 -p /dev/mmcblk0p6 -d Customer )
	[ "$BRAND" == "0x21" ] && BRAND="tolino"
	COLOR=$( ntx_hwconfig -S 1 -p /dev/mmcblk0p6 EPD_Flags CFA )
fi

if [ "$BRAND" == "tolino" ]; then
	case $PCB in
		E70T0*) echo monzaTolino;;
		E60T0*) [ "$COLOR" == "ON" ] && echo spaTolinoColour || echo spaTolinoBW;;
		*) echo vision;;
	esac
else
	case $PCB in
		E60610*) echo trilogy;;
		E60QB*) echo kraken;;
		E606B*) echo kraken;;
		E5061*) echo pixie;;
		E60Q9*) [ "$RES" == "800x600" ] && echo pika || echo alyssum;;
		E606C*) echo dragon;;
		E606G*) echo dahlia;;
		E606F*) echo phoenix;;
		E70Q0*) echo daylight;;
		E60K0*) echo nova;;
		E60U1*) echo nova;;
		E60QL*) echo star;;
		E60QM*) echo snow;;
		E60U0*) echo star;;
		T60Q0*) echo star;;
		E70K0*) echo storm;;
		E80K0*) echo frost;;
		E60U2*) echo luna;;
		EA0P1*) echo europa;;
		E70K1*) echo io;;
		E80P0*) echo cadmus;;
		E60K2*) echo goldfinch;;
		EA0T0*) echo condor;;
		E70T0*) echo monza;;
		E60T0*) [ "$COLOR" == "ON" ] && echo spaColour || echo spaBW;;
		*) echo trilogy;;
	esac
fi
