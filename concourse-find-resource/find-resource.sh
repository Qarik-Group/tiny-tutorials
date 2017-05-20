#!/bin/bash

image_repository=$1
shift
: ${image_repository:?USAGE: resource.sh org/name}
pipelines=($(fly -t sw pipelines | awk '{print $1}'))
for pipeline in "${pipelines[@]}"; do
  echo "Looking $pipeline..."
  fly -t sw get-pipeline -p $pipeline | spruce json | \
    jq -r --arg pipeline $pipeline --arg image $image_repository \
      '.resources[] | select(.type == "docker-image") | select(.source.repository == $image) + {"pipeline": $pipeline}'
done
