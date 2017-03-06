#!/bin/bash

set -x

spruce merge manifest.yml staging-env.yml
spruce merge manifest.yml prod-env.yml

diff <(spruce merge manifest.yml staging-env.yml) <(spruce merge manifest.yml prod-env.yml)

spruce diff <(spruce merge manifest.yml staging-env.yml) <(spruce merge manifest.yml prod-env.yml)
