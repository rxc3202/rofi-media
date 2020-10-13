#! /bin/bash

# Created by Ryan (https://github.com/rxc3202) with inspiration and base code from
# https://github.com/adi1090x

controller="rofi -theme ~/.config/rofi/scripts/media/media.rasi"
launcher="rofi -theme ~/.config/rofi/scripts/media/players.rasi"
stop=" Stop"
next=" Next"
previous=" Prev"


playing_status="$(playerctl status)"
echo $playing_status
if [[ $playing_status == "" ]]; then
    echo "IN LAUNCHER"
    players="spotify\n"
    spotify=" Spotify"
    options="$spotify\n"
    chosen="$(echo -e "$options" | $launcher -p " Available Players:" -dmenu)"
    case $chosen in
        $spotify)
            gtk-launch spotify
    esac

else
    title=$(playerctl metadata --format '{{artist}} - {{title}}')

    # Defines the Play / Pause option content
    if [[ $playing_status == "Paused" ]]; then
        play_pause=" Play"
    else
        play_pause=" Pause"
    fi

    options="$previous\n$play_pause\n$next"
    #chosen="$(echo -e "$options" | $rofi_command -p "$title" -dmenu $active $urgent)"
    chosen="$(echo -e "$options" | $controller -p " $title" -dmenu)"
    case $chosen in
        $previous)
            playerctl previous
            ;;
        $play_pause)
            playerctl play-pause
            ;;
        $next)
            playerctl next
            ;;
    esac

fi

