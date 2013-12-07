#!/bin/bash
cvlc -vvv v4l2:///dev/video0 \
--sout='#transcode{vcodec=mp2v, widht=160, height=120}:standard{fps=10, access=http, mux=ts, vcodec=mp4v, dst=:8080}'
# cvlc -vvvv v4l2:///dev/video0:height=320:width=240:caching=100ms --sout '#transcode{venc=ffmpeg,vcodec=mp2v,width=320,height=240,caching=100ms}:std{access=http,mux=ts,dst=:8080}'

