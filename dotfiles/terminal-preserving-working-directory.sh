#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    cat >&2 <<EOF
Usage: $0 /path/to/terminal [args...]
Hint: The \$TERMINAL environment variable is not standardized, but it's often set
      in user profiles (like .profile) and used in window manager configs
      (such as i3, Sway) to indicate the preferred terminal emulator.
      If you've defined \$TERMINAL, you can invoke this script like so:
      $0 "\$TERMINAL" ...
      If not, consider setting it for consistency across scripts.
EOF
    exit 1
fi
terminal="$1"
shift
if [[ ! -x "$terminal" ]]; then
    echo "There's no executable file behind \"$terminal\" path" >&2
    exit 1
fi

# Gives the CWD (current working directory) of the currently focused terminal window, if there's any.
# If the focused window is not a terminal instance, or if required information cannot be obtained, returns 1.
active_terminal_workdir() {
    # Active window's resource ID.
    # Typical value is: _NET_ACTIVE_WINDOW(WINDOW): window id # 0x6a00003
    local focused_window
    focused_window=$(xprop -root _NET_ACTIVE_WINDOW | grep --ignore-case --only-matching '0x[0-9a-f]\+') || return 1
    # Check if no active window is currently focused (e.g. on an empty workspace).
    [[ -z "$focused_window" || "$focused_window" == '0x0' ]] && return 1

    # `_NET_WM_PID` might not be set.
    # Typical value is: _NET_WM_PID(CARDINAL) = 42718
    local active_pid
    active_pid=$(xprop -id "$focused_window" _NET_WM_PID | grep --only-matching '[0-9]\+') || return 1
    [[ -z "$active_pid" ]] && return 1

    # Check that the executable path matches $TERMINAL
    local active_exe
    active_exe=$(readlink -f "/proc/$active_pid/exe") || return 1
    [[ "$active_exe" != "$terminal" ]] && return 1

    # First shell subprocess (child of the terminal).
    local shell_pid
    shell_pid=$(pgrep --parent "$active_pid" '\b(bash|fish|sh|zsh)\b' | head -n1) || return 1
    [[ -z "$shell_pid" ]] && return 1

    # Resolve the symlink to working directory of the shell.
    local shell_workdir
    shell_workdir=$(readlink "/proc/$shell_pid/cwd") || return 1
    [[ ! -d "$shell_workdir" ]] && return 1
    echo "$shell_workdir"
}

workdir=$(active_terminal_workdir) && cd "$workdir"
exec "$terminal" "$@"
