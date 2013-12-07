#!/bin/bash
./joystick.py | ssh $1 "~/work/lyceum/robotech/control/start.sh"
