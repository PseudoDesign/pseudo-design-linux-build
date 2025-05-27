# pseudo-design-linux-build

This is the build container for the [pseudo-design-linux](https://github.com/PseudoDesign/pseudo-design-linux-dev) project.  Until the need for verbose documentation for the docker container is needed, please see that repository for details on using this container.

## Scripts

### create-build-image.sh

Build the docker image.  By default, this is named `pseudo-design-linux-build:scarthgap`.  You can override this by setting the 
`DOCKER_FULL_IMAGE_NAME` environment variable, e.g.:

`DOCKER_FULL_IMAGE_NAME=my-build-container:and-tag-name ./create-build-image.sh`

### start-build-image.sh

Start the build image, setting various docker environment variables needed by the build container.  See the script for details.

You can override the following environment variables:

```
DOCKER_FULL_IMAGE_NAME - The container name/tag to start.  Defaults to pseudo-design-linux-build:scarthgap.
DOCKER_NETWORK_HOSTNAME - The hostname of the container's network.  Defaults to pseudo-design-linux-build:scarthgap.
```

## Docker Compose (WIP)

This project manages build containers using [Docker Compose](https://docs.docker.com/compose/intro/compose-application-model/).  

