#!/bin/bash
./randommove.py | ssh $1 "~/work/lyceum/robotech/control/start.sh"
