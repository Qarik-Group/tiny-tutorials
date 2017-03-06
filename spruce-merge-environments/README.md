# Separate YAML for different environments

When deploying a similar thing to different environments it is an idea to have a common YAML file, with the differences split into environment-specific YAML files. Then merge them together on demand.

It can be useful to merge together small YAML files even you require JSON.

## Separate environment files

In this `tiny-tutorials/spruce-merge-environments` folder there is a common `manifest.yml` YAML file, and two environment specific YAML files:

```
manifest.yml
prod-env.yml
staging-env.yml
```

`manifest.yml` specifies some common configuration:

```yaml
---
applications:
- name: myapp
  services:
  - myapp-pg
  - myapp-redis
  env:
  - COMMON: some-common-value
```

The `prod-env.yml` adds or overrides anything specifically for the `prod` environment:

```yaml
---
applications:
- name: myapp
  env:
  - SPECIAL: prod-special-token
```

It is simple to merge them for `prod` environment:

```
cd spruce-merge-environments
spruce merge manifest.yml prod-env.yml
```

The resulting environment manifest:

```yaml
applications:
- env:
  - COMMON: some-common-value
    SPECIAL: prod-special-token
  name: myapp
  services:
  - myapp-pg
  - myapp-redis
```

For the `staging` environment:

```
spruce merge manifest.yml staging-env.yml
```

The resulting environment manifest:

```yaml
applications:
- env:
  - COMMON: some-common-value
    SPECIAL: staging-special-token
  - DEBUG: 1
  name: myapp
  services:
  - myapp-pg
  - myapp-redis
```

## Merging by name

How did `spruce merge` combine the two files' `applications` array items?

`spruce merge` cleverly uses of the `name` key of a YAML object to identify whether two YAML objects are merged together, or if they are added together into the resulting array.

## Merge into new file

If the on-demand `spruce merge` output is to be passed as a file into a CLI command, you can either:

* store the `spruce merge` output into new file; or
* pass the output via a temporary file descriptor (next section)

```
spruce merge manifest.yml staging-env.yml > manifest.staging.yml
cf push -f manifest.staging.yml
```

## Merge without writing new file

Using file descriptors, it is possible to skip/avoid the step of ever writing the merged results to a file:

```
cf push -f <(spruce merge manifest.yml staging-env.yml)
```

The net result is the same as the preceding section. The `cf push -f <file>` command behaves as if it received a file.
