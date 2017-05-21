#!/bin/bash

# USAGE:
#   org=cloudfoundry-community ./members.sh
#   export org=starkandwayne; ./members.sh | tee members-$org.log

: ${GITHUB_TOKEN:?required}
: ${org:?which organization to search thru for first author}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
links_regexp='Link: <(.*)>; rel="next", <(.*)>; rel="last"'

function list_member_logins() {
  members=$1
  curl -s -H "Authorization: token $GITHUB_TOKEN" $members | jq -r ".[].login"
}

next_members=https://api.github.com/orgs/$org/members

until [[ "${next_members:-X}" == "X" ]]; do
  list_member_logins $next_members
  next_members_links=$(curl -s -H "Authorization: token $GITHUB_TOKEN" $next_members -I 2>&1 | grep "^Link")
  if [[ $next_members_links =~ $links_regexp ]]; then
    next_members="${BASH_REMATCH[1]}"
  else
    next_members=
  fi
done
