#!/bin/sh
droidcam-cli -dev=/dev/video0 192.168.1.151 4747 & disown
mpv av://v4l2:/dev/video0 --no-mouse-movements --no-keepaspect --profile=low-latency --untimed
