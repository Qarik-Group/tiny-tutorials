#!/bin/bash

set -x

cat values.yml

spruce json values.yml

spruce json values.yml | jq .
