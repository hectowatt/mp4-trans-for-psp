#!/bin/bash
before=$1
after=$2

# before.mp4 is the original video file, and after.mp4 is the output file
ffmpeg -i $before \
-c:v libx264 \
-profile:v baseline \
-level 2.1 \
-pix_fmt yuv420p \
-vf "scale=480:272" \
-r 29.97 \
-b:v 768k \
-c:a aac \
-profile:a aac_low \
-ar 44100 \
-b:a 128k \
-movflags +faststart \
$after