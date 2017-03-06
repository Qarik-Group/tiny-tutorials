# Merge YAML array items

It can be convenient to split large YAML files into many smaller parts: easier to split out concerns, or compartmentalize. Or the files might be already spilt into many files and you want them merged together.

For example, some of the `tiny-tutorials` subfolders have a `metadata.yml` that describes that tutorial. For example, this tutorial file is:

```yaml
---
tutorials:
- name: Merge YAML array items
  folder: spruce-merge-array-items
```

The `tiny-tutorials/spruce-json/metadata.yml` file looks like:

```yaml
---
tutorials:
- name: Convert YAML to JSON
  folder: spruce-json
```

We have a `tutorials` array, but the items are in separate files.

`spruce merge` will naturally merge all the items into a single YAML array.

From the root folder of the `tiny-tutorials` repo:

```
spruce merge */metadata.yml
```

The output might look similar to:

```yaml
tutorials:
- folder: spruce-json
  name: Convert YAML to JSON
- folder: spruce-merge-array-items
  name: Merge YAML array items
```
