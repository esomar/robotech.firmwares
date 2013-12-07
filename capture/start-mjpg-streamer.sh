#!/bin/bash

# This command starts mjpg-streamer server
# Should be run in the directory where mjpg-streamer was compiled
TRUENAME=`readlink -f $0`
echo $TRUENAME
DIRNAME=`dirname $TRUENAME`
cd $DIRNAME/../mjpg-streamer/mjpg-streamer

LD_LIBRARY_PATH=./ ./mjpg_streamer -i "input_uvc.so -d /dev/video$1 -r 160x120  -f 10 -y -q 90" -o "output_http.so -p 8080 -n -w ./www"
