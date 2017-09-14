#!/bin/bash

for org in $@; do
  export org
  echo org: $org
  echo

  if [[ ! -f authors-$org.log ]]; then
    echo "Missing authors-$org.log. Run create-authors-logs.sh first."
    exit 1
  fi
  cat authors-$org.log |egrep "($(cat members-$org.log | paste -sd "|" -))" | awk '{print $2}' | sort | uniq -c | sort
done
