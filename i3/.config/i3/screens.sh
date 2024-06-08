#!/bin/sh
sleep 3
xrandr --output DP-0 --mode 1920x1080 --rate 144.00 --pos 3840x0 --rotate normal \
	--output DP-1 --off \
	--output HDMI-0 --primary --mode 1920x1080 --rate 144.00 --pos 1920x0 --rotate normal \
	--output DP-2 --off \
	--output DP-3 --off \
	--output HDMI-1 --mode 1920x1080 --rate 144.00 --pos 0x0 --rotate normal \
	--output DP-4 --off \
	--output DP-5 --off
