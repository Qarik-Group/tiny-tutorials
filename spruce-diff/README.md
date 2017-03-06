# Show differences in YAML files

Not all YAML files are the same. It can be difficult to to spot differences in very large YAML files.

`spruce diff` makes this nice for you:

![diffs](spruce-diff-differences.png)

## Files with differences

Try anyone of the following equivalent commands:

```
spruce diff spruce-diff/*-env.yml
spruce diff spruce-diff/{prod,staging}-env.yml
spruce diff spruce-diff/prod-env.yml spruce-diff/staging-env.yml
```

The output will be similar to:

```
$.applications[myapp].env[1] added
  DEBUG: 1

$.applications[myapp].env[0].SPECIAL changed value
  from prod-special-token
    to staging-special-token

$.applications[myapp].routes[0] changed value
  from myapp.starkandwayne.com
    to myapp-staging.starkandwayne.com
```

## Matching files

```
spruce diff spruce-diff/prod-env.yml spruce-diff/prod-env.yml
```

The output will be similar to:

```
both files are semantically equivalent; no differences found!
```
