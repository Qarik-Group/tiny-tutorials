#!/bin/bash

set -x

vault_base=${vault_base:-secret/tiny-tutorials-demo}

safe gen 20 $vault_base/staging/users/admin password
safe get $vault_base/staging/users/admin
safe get $vault_base/staging/users/admin:password
