#!/bin/bash

send_notification() {
    # Get brightness percentage
    brightness=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')

    # Set icon based on brightness level
    if [ "$brightness" -le 33 ]; then
        icon="display-brightness-low-symbolic"
    elif [ "$brightness" -le 66 ]; then
        icon="display-brightness-medium-symbolic"
    else
        icon="display-brightness-high-symbolic"
    fi

    # Send the notification
    dunstify -i "$icon" -r 2594 -u normal "Brightness: ${brightness}%" -h "int:value:${brightness}"
}

case $1 in
    up)
        brightnessctl -e4 -n2 set 5%+
        send_notification
        ;;
    down)
        brightnessctl -e4 -n2 set 5%-
        send_notification
        ;;
esac
