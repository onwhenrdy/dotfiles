# Docker Cheatsheet

## Run

```bash
# Run container in background with port mapping 8080:80 and name mycontainer
docker run -d -p 8080:80 --name mycontainer myimage
# interactive mode with tty and remove container after exit
docker run --rm -it myimage
# Run container with volume mapping
docker run -v /host:/container myimage
```

## Watch

```bash
# List all containers
docker ps -a
# List all images
docker images
# Check status of all running containers
docker status
```

## Purge

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
```

### Stop and Start

```bash
# Stop container
docker stop <container_id>
# Stop all containers
docker stop $(docker ps -a -q)
# Start container that was stopped
docker start <container_id>
```

### Stop and Start

```bash
# Stop container
docker stop <container_id>
# stop all
docker stop $(docker ps -a -q)
```
