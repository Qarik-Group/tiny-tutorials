#!/bin/bash

: ${GITHUB_TOKEN:?required}

: ${repo:?required}
commit_links_regexp='Link: <(.*)>; rel="next", <(.*)>; rel="last"'
last_commits=https://api.github.com/repos/$repo/commits
commit_links=$(curl -s -H "Authorization: token $GITHUB_TOKEN" $last_commits -I 2>&1 | grep "^Link")
if [[ $commit_links =~ $commit_links_regexp ]]; then
  last_commits="${BASH_REMATCH[2]}"
fi

author=$(curl -s -H "Authorization: token $GITHUB_TOKEN" ${last_commits} | jq -r ".[-1].author.login // .[-1].commit.author")
echo "$repo $author"
