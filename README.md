# Base Docker Image

This image is a base image for NEC SX-Aurora TSUBASA development
without the NEC compilers and runtimes.

It does not contain any compiler!

## Build

```
VEOS=2.11.1
docker build --network host --tag efocht/ve-base-dev:veos$VEOS .

# tag as 'latest', if you want
docker image tag efocht/ve-base-dev:veos$VEOS efocht/ve-base-dev:latest
```

## Upload to dockerhub
```
docker push efocht/ve-base-dev:veos$VEOS
docker push efocht/ve-base-dev:latest
```

## Run


