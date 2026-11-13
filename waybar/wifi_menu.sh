#!/usr/bin/env bash
# Show available wifi networks in wofi; the current one is marked with ●.

nmcli dev wifi rescan >/dev/null 2>&1

# IN-USE:SSID:SIGNAL:SECURITY (terse mode escapes ':' in values as '\:')
list=$(nmcli -t -e yes -f IN-USE,SSID,SIGNAL,SECURITY dev wifi list 2>/dev/null |
    awk -F':' '
    {
        use = ($1 == "*") ? 1 : 0
        # fields from the right are never escaped-colon safe except SSID; rebuild SSID
        sec = $NF; sig = $(NF-1)
        ssid = $2
        for (i = 3; i <= NF-2; i++) ssid = ssid ":" $i
        gsub(/\\:/, ":", ssid)
        if (ssid == "") next
        if (!(ssid in best) || sig > best[ssid]) best[ssid] = sig
        if (use) cur[ssid] = 1
        secm[ssid] = sec
    }
    END {
        for (s in best) {
            printf "%d\t%s\t%s\t%s\n", (s in cur) ? 1 : 0, best[s], s, secm[s]
        }
    }' | sort -t$'\t' -k1,1nr -k2,2nr |
    awk -F'\t' '{
        mark = ($1 == 1) ? "●" : " "
        lock = ($4 != "" && $4 != "--") ? " 🔒" : ""
        printf "%s %s  %s%%%s\n", mark, $3, $2, lock
    }')

[ -z "$list" ] && exit 0

choice=$(printf '%s\n' "$list" | wofi --dmenu --prompt "WiFi" --cache-file /dev/null) || exit 0
[ -z "$choice" ] && exit 0

# Already connected -> nothing to do
case "$choice" in "●"*) exit 0 ;; esac

# Strip leading mark, trailing "  NN%[ 🔒]"
ssid=$(printf '%s' "$choice" | sed -E 's/^. //; s/  [0-9]+%( 🔒)?$//')

if nmcli -t -f NAME connection show | grep -Fxq "$ssid"; then
    nmcli connection up id "$ssid"
else
    case "$choice" in
    *"🔒")
        pass=$(wofi --dmenu --password --prompt "Password for $ssid" --cache-file /dev/null </dev/null) || exit 0
        nmcli dev wifi connect "$ssid" password "$pass"
        ;;
    *) nmcli dev wifi connect "$ssid" ;;
    esac
fi
