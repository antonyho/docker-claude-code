# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Docker containerization project for Claude Code, providing a containerized environment to run the Claude Code CLI tool. The setup uses a Node.js slim base image and installs the official Claude Code package.

## Common Commands

### Building the Docker Image
```bash
docker build -t antonyho/claude-code .
```

### Running the Container
```bash
# Create profile directory first
mkdir .claude-profile

# Run the container with proper permissions
docker run -it --rm \
    --name claude-code \
    --userns=host \
    -u $(id -u):$(id -g) \
    -v $(pwd)/.claude-profile:/home/node \
    -v $(pwd):/workspace \
    -w /workspace \
    antonyho/claude-code
```

### Publishing to Docker Hub
```bash
docker push antonyho/claude-code
```

## Architecture Notes

### Docker Configuration
- Uses `node:current-slim` as base image for minimal footprint
- Installs Claude Code globally via npm
- Sets `claude` as the default command
- Designed to mount host directories for persistent storage

### Volume Mounts
- `.claude-profile` directory is mounted to `/home/node` for Claude Code configuration persistence
- Current working directory is mounted to `/workspace` for code access
- Container runs with host user permissions to avoid file ownership issues

### Permission Handling
The Docker run command includes specific flags to handle file permissions:
- `--userns=host` disables user namespace isolation
- `-u $(id -u):$(id -g)` runs container with host user/group IDs
- These prevent permission issues when Claude Code creates files in mounted volumes