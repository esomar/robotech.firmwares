#!/bin/bash
svn co https://mjpg-streamer.svn.sourceforge.net/svnroot/mjpg-streamer mjpg-streamer
pushd .
cd mjpg-streamer/mjpg-streamer
make
popd