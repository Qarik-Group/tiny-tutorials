#!/bin/bash

# USAGE:
#   org=cloudfoundry-community ./authors.sh
#   org=cloudfoundry-community ./authors.sh | tee authors.log
#
# BONUS: count number of repos created by authors
#   $ cat authors.log | awk '{print $2}' | sort | uniq -c | sort
#   ...
#    3 thomasmmitchell
#    8 soutenniza
#    11 geofffranks
#    13 frodenas
#    13 rkoster
#    17 jhunt
#    28 lnguyen
#    67 drnic
#
# BONUS: count number of repos created by authors, filtered by members.sh
#   $ cat authors.log | egrep "($(cat members-starkandwayne.log | paste -sd "|" -))" | awk '{print $2}' | sort | uniq -c | sort
#   1 cweibel
#   1 fearoffish
#   1 jrbudnack
#   1 mrferris
#   1 ramonskie
#   2 bodymindarts
#   2 dennisjbell
#   2 givett
#   2 johnlonganecker
#   2 wayneeseguin
#   3 thomasmmitchell
#   8 soutenniza
#   11 geofffranks
#   13 frodenas
#   13 rkoster
#   17 jhunt
#   28 lnguyen
#   67 drnic
#
# BONUS: total repos initially created by a member of an organization
#   $ cat authors.log | egrep "($(cat members-starkandwayne.log | paste -sd "|" -))" | awk '{print $2}' | sort | uniq -c | sort | awk '{print $1}'| paste -sd+ - | bc
#   175

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
