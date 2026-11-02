#!/usr/bin/env bash
# Spawn the startup apps one at a time and move each to its workspace.
# Run once from sway config (exec ~/.config/sway/startup-apps.sh).
# Detects the new window by diffing container ids, so no app_id/assign tricks
# are needed (and $mod+b / $mod+t spawns are unaffected).

window_ids() {
    swaymsg -t get_tree | jq -r '.. | objects | select(.pid? and (.type == "con" or .type == "floating_con")) | .id' | sort
}

# spawn_to <workspace> <command...>
spawn_to() {
    local ws=$1; shift
    local before id
    before=$(window_ids)
    swaymsg -q exec "$*"
    for _ in $(seq 1 300); do   # up to ~20s
        id=$(comm -13 <(echo "$before") <(window_ids) | head -n1)
        if [ -n "$id" ]; then
            swaymsg -q "[con_id=$id] move container to workspace $ws"
            return
        fi
        sleep 0.2
    done
    echo "startup-apps: no window appeared for: $*" >&2
}

spawn_to s.term wezterm start
spawn_to 2.web  brave
spawn_to 1.msg  /usr/bin/goofcord
