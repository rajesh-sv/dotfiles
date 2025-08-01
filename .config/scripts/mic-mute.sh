#!/bin/bash

# Toggle mute
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

# Get mute status
is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q 'MUTED' && echo "yes" || echo "no")

if [[ "$is_muted" == "yes" ]]; then
    dunstify -i "microphone-sensitivity-muted-symbolic" -r 2595 -u normal "Microphone Muted"
else
    dunstify -i "audio-input-microphone-symbolic" -r 2595 -u normal "Microphone On"
fi
