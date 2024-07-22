# Docker Cheatsheet

## Build

```bash
# Build image with tag myimage with Dockerfile in current directory
docker build -t myimage .
# Build image with tag myimage with Dockerfile in specific directory
docker build -t myimage /path/to/Dockerfile
# rebuild image without cache
docker build --no-cache -t myimage .s
```

## Run

```bash
# Run container in background with port mapping 8080:80 and name mycontainer
docker run -d -p 8080:80 --name mycontainer myimage
# interactive mode with tty and remove container after exit
docker run --rm -it myimage
# Run container with volume mapping
docker run -v /host:/container myimage
```

### Stop and Start

```bash
# Stop container
docker stop <container_id>
# Kill container
docker kill <container_id>
# Stop all containers
docker stop $(docker ps -a -q)
# Start container that was stopped
docker start <container_id>
# Restart container
docker restart <container_id>
# Pause container
docker pause <container_id>
# Unpause container
docker unpause <container_id>
```

## Watch

```bash
# List all containers
docker ps -a
# List all images
docker images
# Check status of all running containers
docker stats
```

## Prune

```bash
# Remove all stopped containers, all dangling images, and all unused networks
docker system prune
# Remove all stopped containers
docker container prune
# Remove all dangling images
docker image prune
# Remove all unused volumes
docker volume prune
# Remove all unused networks
docker network prune
# Remove all build caches
docker builder prune
```

## Remove

```bash
# Remove container
docker rm <container_id>
# Remove image
docker rmi <image_id>
```

## Interact

```bash
# Copy files from container to host
docker cp <container_ id>:/path/to/file /path/to/destination
# Get shell access to container
docker exec -it <container_id> /bin/bash
```

### Misc

```bash
# Get logs of container
docker logs <container_id>

# history of image
docker history <image_id>
# inspect image: shows metadata of image
docker inspect <image_id>
# inspect container: shows metadata of container
docker inspect <container_id>

```
