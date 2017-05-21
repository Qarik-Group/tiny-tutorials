#!/bin/bash

: ${GITHUB_TOKEN:?required}

: ${repo:?required}
repo_created_at=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$repo | jq -r .created_at)
author=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$repo/commits\?until\=$repo_created_at | jq -r ".[0].author.login")
echo "$repo $author $repo_created_at"
