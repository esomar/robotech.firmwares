#!/bin/bash
python -u ../capture/follow2.py $1:8080| ssh $1 "~/work/lyceum/robotech/control/start.sh"
