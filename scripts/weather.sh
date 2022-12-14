#!/bin/env bash

curl -s "wttr.in?format=%t" > /tmp/weather

if [[ $(grep -F -c -i "redirect" /tmp/weather ) -gt 0 ]]; then
	echo 'Sign in to network'
elif [[ $(grep -F -c -i "Unknown location" /tmp/weather) -gt 0 ]]; then
	echo "wttr.in is temporarily down"
else
	echo "  $(cat /tmp/weather)"
fi
