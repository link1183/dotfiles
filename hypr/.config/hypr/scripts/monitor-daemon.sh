#!/bin/bash

# Path to the dynamic config file
DYNAMIC_CONFIG=~/.config/hypr/monitors.conf

# Function to dynamically include the correct monitor setup
connected_monitors=$(hyprctl monitors -j | jq -r '.[] | .name')

if echo "$connected_monitors" | grep -q "DP-3"; then
	# DP-3 setup
	cp ~/.config/hypr/monitor_dp3.conf $DYNAMIC_CONFIG
else
	# Default setup for eDP-1 only
	cp ~/.config/hypr/monitor_default.conf $DYNAMIC_CONFIG
fi

# Reload Hyprland to apply the new configuration
hyprctl reload
