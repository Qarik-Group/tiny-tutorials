#!/bin/bash

for org in $@; do
  export org
  echo org: $org
  ./authors.sh | tee authors-$org.log

  echo members: $org
  ./members.sh | tee members-$org.log
done
