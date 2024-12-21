#!/bin/bash

echo "All variables passed to the script: $@"
echo "Number of variables passed: $#"
echo "Script name: $0 "
echo "Current working directory: $pwd"
echo "home directory if current user : $home"
echo "PID of the script executing now: $$"
sleep 100 &
echo "PID of last background commandL:$!"
