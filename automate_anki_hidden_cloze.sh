 
#!/bin/bash
# set -e

n_notes=0
POLL_INTERVAL=0.5 # seconds
DEBUG=0 # 1 for debug

debug () {
    if [[ $DEBUG -eq 1 ]]; then
        echo "$1"
    fi
}

if [[ $DEBUG -eq 0 ]]; then
    xdotool () {
        command xdotool $@ 2> /dev/null
    }
fi

xdotool search --onlyvisible --classname "Anki" windowactivate --sync
orig_window=$(xdotool getactivewindow)

debug "$orig_window"

while true
do
    # Escape all editing windows
    debug "Escaping all editing windows"
    curr_windows=($(xdotool search --onlyvisible --classname "Anki"))
    until [[ ${#curr_windows[@]} -eq 1 ]]; do
        for window in "${curr_windows[@]}"; do
            xdotool windowactivate $window
            debug "Escaping window $window"
            xdotool key --window $window Escape
        done
        curr_windows=($(xdotool search --onlyvisible --classname "Anki"))
    done

    # Make sure the window focused is the original window
    debug "Checking if the original window is focused"
    current_window=$(xdotool getactivewindow)
    if [[ "$orig_window" != "$current_window" ]]; then
        curr_windows=($(xdotool search --onlyvisible --classname "Anki"))
        if [[ ${#curr_windows[@]} -eq 1 ]]; then
            debug "Error: Only 1 window is open, but it is not the original window."
        elif [[ ${#curr_windows[@]} -eq 2 ]]; then
            continue
        else
            debug "Error: More than 2 windows are open."
            exit 1
        fi
    fi

    # Press e in original window
    debug "Pressing e in original window"
    xdotool key --window ${orig_window} e
    
    # Press Esc in new window
    sleep 0.5
    debug "Pressing Esc in new window"
    curr_windows=($(xdotool search --onlyvisible --classname "Anki"))
    until [[ ${#curr_windows[@]} -eq 1 ]]; do
        for window in "${curr_windows[@]}"; do
            if [[ $window == $orig_window ]]; then
                continue
            fi
            xdotool windowactivate $window
            xdotool key --window $window Escape
        done
        curr_windows=($(xdotool search --onlyvisible --classname "Anki"))
    done

    # Press = in original window
    debug "Pressing = in original window"
    until [[ $(xdotool getactivewindow) == $orig_window ]]; do
        sleep $POLL_INTERVAL
    done
    xdotool windowactivate $orig_window
    xdotool key --window $orig_window equal

    n_notes=$(($n_notes+1))
done

debug "$n_notes notes were rendered."
