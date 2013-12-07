#!/bin/bash
ssh $1 "arecord -F 5 -t wav -f dat | lame -" | mpg123 -

