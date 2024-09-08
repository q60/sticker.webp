#!/usr/bin/env bash
tty=$(tty | sed 's/\/dev\///')
shell=$(ps -e --forest -o tty,pid | grep "$tty" | awk 'NR == 1 { print $2 }')
terminal_pid=$(ps -p "$shell" -o ppid= | xargs)
argv0=$(awk 'BEGIN { RS = "\0" } NR == 1 { print $0 }' </proc/$terminal_pid/cmdline)
terminal=$(basename "$argv0")

case $terminal in
kitty)
	tail -n +{LINES} "$0" | kitten icat --align left
	;;
foot | konsole | xfce4-terminal)
	tail -n +{LINES} "$0" | img2sixel
	;;
*)
	echo "$terminal is not supported yet"
	exit 1
	;;
esac

exit
