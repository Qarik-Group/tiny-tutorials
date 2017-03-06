# Convert YAML to JSON

Since `spruce` works so well with YAML files - merging them, importing data from Vault - it can be convenient to use `spruce` even when you ultimately want JSON. Or you might want to use `jq` to find or process values within your YAML/JSON.

`spruce json` makes this step easy.

```
cat >/tmp/values.yml <<YAML
---
tutorial:
  name: "Convert YAML to JSON"
  folder: spruce-json
YAML
```

To convert this YAML file into JSON:

```
spruce json /tmp/values.yml
```

The output looks like:

```json
{"tutorial":{"folder":"spruce-json","name":"Convert YAML to JSON"}}
```

## Find values from YAML with jq

Format the JSON nicely with `jq`:

```
spruce json /tmp/values.yml | jq .
```


The output is:

```json
{
  "tutorial": {
    "folder": "spruce-json",
    "name": "Convert YAML to JSON"
  }
}
```

Find the `.tutorial.folder` value:

```
spruce json /tmp/values.yml | jq -r .tutorial.folder
```

The output is the cleanly formatted:

```
spruce-json
```
