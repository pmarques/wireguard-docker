#!/usr/bin/env bash

CONFIG_PATH="/etc/wireguard"
CONFIG_FILE="wg0.conf"

all_interfaces () {
    command="${1}"
    for file in $(find "${CONFIG_PATH}" -type f -regex "${CONFIG_PATH}/wg[0-9]*.conf" -maxdepth 1) ; do
        wg-quick "${command}" "${file}"
    done
}

finish () {
    echo "$(date): stopping wireguard"

    all_interfaces down

    exit 0
}

trap finish TERM INT QUIT

all_interfaces up

while IFS="," read -r event file; do
    CONFIG="${CONFIG_PATH}/${file}"
    INTERFACE="${file%.*}"

    case "${event}" in
        "CLOSE_WRITE:CLOSE")
            echo "$(date): Wireguard (re)load config ${CONFIG}"
            # If the interface is alredy up, shut it down before
            # bringing it up. This is required to update the IPs
            # iptables etc when using wg-quick
            if ip link show dev ${INTERFACE} &>/dev/null ; then
                wg-quick down "${CONFIG}"
            fi

            wg-quick up "${CONFIG}"
        ;;

        *)
            echo "Unknown event [${event}]"
        ;;
    esac
done < <(inotifywait -e CLOSE_WRITE ${CONFIG_PATH} --include "${CONFIG_FILE}" --monitor --format "%:e,%f")
