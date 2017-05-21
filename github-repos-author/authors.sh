#!/bin/bash

# USAGE:
#   org=cloudfoundry-community ./authors.sh
#   org=cloudfoundry-community ./authors.sh | tee authors.log

: ${GITHUB_TOKEN:?required}
: ${org:?which organization to search thru for first author}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
links_regexp='Link: <(.*)>; rel="next", <(.*)>; rel="last"'

function fetch_authors() {
  next_repos=$1
  repos=($(curl -s -H "Authorization: token $GITHUB_TOKEN" $next_repos | jq -r ".[].full_name"))
  for repo in "${repos[@]}"; do
    $DIR/author.sh
  done
}

next_repos=https://api.github.com/orgs/$org/repos

until [[ "${next_repos:-X}" == "X" ]]; do
  fetch_authors $next_repos

  next_repo_links=$(curl -s -H "Authorization: token $GITHUB_TOKEN" $next_repos -I 2>&1 | grep "^Link")
  if [[ $next_repo_links =~ $links_regexp ]]; then
    next_repos="${BASH_REMATCH[1]}"
  else
    next_repos=
  fi
done
