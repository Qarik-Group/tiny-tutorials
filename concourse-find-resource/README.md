# Concourse - find a resource in a pipeline

At [Stark & Wayne](https://starkandwayne.com) we have over 85 https://concourse.ci pipelines running out company.

One of them was pushing out `docker:///starkandwayne/concourse` but I didn't know which one.

`find-resource.sh` helped find it.

```
./find-resource.sh starkandwayne/concourse
```

This command searched thru each pipeline looking for `docker-image` resources with the repository `starkandwayne/concourse`:

```
Looking concourse-tutorial...
Looking bosh-lites...
Looking concourse-deployment...
Looking cloudfoundry-utils...
Looking covalence...
Looking docker-images...
{
  "name": "concourse:latest-rc @dockerhub",
  "source": {
    ...
    "repository": "starkandwayne/concourse",
    "tag": "latest-rc",
    "username": "starkandwaynebot"
  },
  "type": "docker-image",
  "pipeline": "docker-images"
}
{
  "name": "concourse:latest @dockerhub",
  "source": {
    ...
    "repository": "starkandwayne/concourse",
    "tag": "latest",
    "username": "starkandwaynebot"
  },
  "type": "docker-image",
  "pipeline": "docker-images"
}
...
```

Found the pipeline: `docker-images`
