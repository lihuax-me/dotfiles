#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/$(id -u)
export PATH=$PATH:/usr/bin

hyprlock &

sleep 1

systemctl suspend

