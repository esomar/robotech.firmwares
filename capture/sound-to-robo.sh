#!/bin/bash
arecord -F 5 -t wav -f dat  | lame - | ssh $1 "mpg123 -"
