# Claude Code in Docker Container

A Docker containerization of the Claude Code CLI tool for easy deployment and consistent environment setup.

## Prerequisites

- Docker installed and running
- Claude account or API key for authentication

## Quick Start

### Using the Pre-built Image

```bash
# Run Claude Code in Docker
docker run -it --rm \
    --name claude-code \
    --userns=host \
    -u $(id -u):$(id -g) \
    -v $(pwd):/workspace \
    -w /workspace \
    ghcr.io/antonyho/docker-claude-code
```

### Building Your Own Image

If you prefer to build the image yourself: (replace my namespace "antonyho" with yours)

```bash
# Build the image
docker build -t antonyho/docker-claude-code .
```

## How It Works

### First Launch Setup
On first launch, Claude Code will:
1. Ask for your theme preference
2. Prompt you to sign in with your Claude account or API key
3. Create a `CLAUDE.md` file in your current directory

### Directory Structure
- Current directory - Mounted to `/workspace` for code access
- `.claude-cfg` directory will be initialised by Claude Code on first launch

*Consider adding the `.claude-cfg` directory to your project's `.gitignore` to keep your Claude session private.*

### Permission Handling
The Docker run command includes specific flags to handle file permissions:
- `--userns=host` - Disables user namespace isolation
- `-u $(id -u):$(id -g)` - Runs container with your host user/group IDs

This prevents permission issues when Claude Code creates files in mounted volumes.
**You are very likely that you don't need them if you have not configured user namespace on your Docker service.**
