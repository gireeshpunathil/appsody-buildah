#!/bin/bash

# gitsource variable is supplied by the caller.
cd /workspace/$gitsource

# Extract everything into /workspace/extracted, the image
# content goes to the vortex, content in the current
# folder into user-app, and the rest, as per the mounts.
appsody extract --buildah --target-dir $path_to_context

# Compose and push the image to the registry
cd $path_to_context
imageid=`buildah bud --format=docker -t $image .`
buildah push --tls-verify=false $imageid $image
