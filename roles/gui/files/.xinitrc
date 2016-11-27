#!/bin/sh

exec startxfce4 &
xfconf-query -c xfwm4 -p /general/use_compositing -s false
