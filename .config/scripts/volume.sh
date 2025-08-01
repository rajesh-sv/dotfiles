#!/bin/bash

send_notification() {
    # Get volume and mute status
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | cut -d'.' -f1)
    is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q 'MUTED' && echo "yes" || echo "no")

    # Set icon based on volume level
    if [[ "$is_muted" == "yes" ]]; then
        icon="audio-volume-muted-blocking-symbolic"
        dunstify -i "$icon" -r 2593 -u normal "Muted"
    else
        if [ "$volume" -le 33 ]; then
            icon="audio-volume-low-symbolic"
        elif [ "$volume" -le 66 ]; then
            icon="audio-volume-medium-symbolic"
        else
            icon="audio-volume-high-symbolic"
        fi
        # Send the notification with a progress bar
        dunstify -i "$icon" -r 2593 -u normal "Volume: ${volume}%" -h "int:value:${volume}"
    fi
}

case $1 in
    up)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
        send_notification
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        send_notification
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        send_notification
        ;;
esac
