#!/bin/bash


sudo systemctl stop zapret.service

cleanup() {
    sudo systemctl start zapret.service
    exit 0
}

trap cleanup EXIT

pkexec env DISPLAY=$DISPLAY WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_SESSION_TYPE=$XDG_SESSION_TYPE XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR hiddify
sudo systemctl start zapret.service


