# Unofficial datadog agent for armhf
## Prerequisites for build
- Create buildx instance https://community.arm.com/developer/tools-software/tools/b/tools-software-ides-blog/posts/getting-started-with-docker-for-arm-on-linux

## Build
```bash
cd Dockerfiles/agent
docker buildx build --platform linux/arm/v7 --push -t koukihai/rpi-dd-agent -f armhf/Dockerfile .
```

## Thanks to:
- https://github.com/DataDog/datadog-agent and their arm64 build scripts
- https://github.com/adrienkohlbecker/datadog-agent-arm and his custom agent 6.15 build for armhf

## TODO:
- cluster agent
- auto-generate from arm64 build files
- look into upgrading agent custom build to 7.x