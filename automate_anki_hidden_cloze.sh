 
#!/bin/bash
while true
do
echo "loop"
xdotool search --onlyvisible --classname "Anki" windowactivate --sync key --delay 20 e
xdotool getactivewindow
sleep 2
xdotool getactivewindow
xdotool key --delay 20 Escape
sleep 2
xdotool search --onlyvisible --classname "Anki" windowactivate --sync key --delay 20 equal
xdotool getactivewindow
sleep 4
done
