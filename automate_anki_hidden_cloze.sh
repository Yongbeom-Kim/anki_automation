 
#!/bin/bash
# set -e

n_notes=0

while true
do
    xdotool search --onlyvisible --classname "Anki" windowactivate --sync key --delay 20 e
    orig_window=$(xdotool getactivewindow)
    # echo $orig_window

    sleep 2

    new_window=$(xdotool getactivewindow)
    # echo $new_window

    if [[ "$orig_window" == "$new_window" ]]; then
        break
    fi

    xdotool key --delay 20 Escape
    sleep 1
    xdotool search --onlyvisible --classname "Anki" windowactivate --sync key --delay 20 equal
    sleep 4

    n_notes=$(($n_notes+1))
done

echo "$n_notes notes were rendered."
