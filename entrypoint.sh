#!/bin/bash
set -e

/etc/init.d/nordvpn start && sleep 5
nordvpn login --token ${TOKEN}
nordvpn connect P2P
sleep infinity