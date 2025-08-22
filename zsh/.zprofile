# Get the aliases & functions
[ -f $HOME/.zshrc ] && . $HOME/.zshrc

if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
	if ! test -d "${XDG_RUNTIME_DIR}"; then
		mkdir "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi
fi

if ! pgrep -x sway > /dev/null; then
	# Sets up waybar monitoring in background b4 starting sway
	CONFIG_FILES="$HOME/.config/waybar/config $HOME/.config/waybar/style.css"

	# Function to monitor & restart waybar
	monitor_waybar() {
		trap "killall waybar 2>/dev/null" EXIT

		while true; do
			waybar &
			WAYBAR_PID=$!

			# Wait for config file changes or waybar to exit
			inotifywait -e create,modify $CONFIG_FILES 2>/dev/null || break

			# Kill current waybar instance
			kill $WAYBAR_PID 2>/dev/null
			killall waybar 2>/dev/null
			sleep 0.5
		done
	}

	# Start waybar monitoring in background
	monitor_waybar &

	# Start sway (this will take over the session)
	exec dbus-run-session sway
fi
