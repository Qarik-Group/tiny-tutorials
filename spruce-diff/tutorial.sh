#!/bin/bash

set -x

diff staging-env.yml prod-env.yml

spruce diff staging-env.yml prod-env.yml

spruce diff <(spruce merge manifest.yml staging-env.yml) <(spruce merge manifest.yml prod-env.yml)
