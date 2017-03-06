#!/bin/bash

set -x

cat manifest.yml

spruce json manifest.yml

spruce json manifest.yml | jq .
