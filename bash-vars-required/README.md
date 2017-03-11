# Required variables for bash scripts

You can enforce that all variables must be specified with `set -u`, or you can discerningly use `${var1:?required}` to show errors.

![req](bash-required-variables.gif)
