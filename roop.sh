#!/bin/bash

# 複数の動画を並列で変換するためのスクリプト
# 
source_dir=$1
title=$2
season=$3
amount=$4
identifier=$5


number_of_cores=$(nproc)

echo "Source: $source_dir"
echo "Title: $title"
echo "Season: $season"
echo "Amount: $amount"
echo "Identifier: $identifier"

dl-loop() {
  local episode="$1"
  local source_dir="$2"
  local title="$3"
  local season="$4"
  local amount="$5"
  local identifier="$6"
  local ext="mp4"
  local before="${source_dir%/}/${title}-${season}-${episode}.${ext}"
  local after="${source_dir%/}/${title}-${season}-${episode}${identifier}.${ext}"

  echo "-------------------------------------------"
  echo "Processing: ${episode}"
  echo "Source: ${source_dir}"
  echo "Title: ${title}"
  echo "Season: ${season}"
  echo "Amount: ${amount}"
  echo "Identifier: ${identifier}"
  echo "Before: ${before}"
  echo "After: ${after}"
  echo "-------------------------------------------"

  bash script.sh "$before" "$after"
}

export -f dl-loop

seq 1 "$amount" | parallel -j "$number_of_cores" dl-loop {} "$source_dir" "$title" "$season" "$amount" "$identifier"