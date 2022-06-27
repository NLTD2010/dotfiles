#!/bin/bash

DND_LOCK_FILE="$HOME/.cache/dnd-lock.lock"
EWW_BIN="$HOME/.local/bin/eww"

finish() {
	${EWW_BIN} update noti=false; sleep 0.270
	${EWW_BIN} close notification-history
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
	${EWW_BIN} daemon
	sleep 1
else
	if [[ ! -f "$DND_LOCK_FILE" ]]; then
		KILLED=false
		for pid in $(pidof -x openEwwPopup.sh); do
			if [ $pid != $$ ]; then
				kill -9 $pid
				KILLED=true
				finish
			fi
		done >/dev/null

		if ! $KILLED; then
			sleep 0.5
			${EWW_BIN} update noti=true
			${EWW_BIN} open notification-history
			canberra-gtk-play -i message
		fi

		sleep 5
		finish
		unset KILLED
	fi
fi