# Claude Code in Docker Container

A Docker containerization of the Claude Code CLI tool for easy deployment and consistent environment setup.

## Prerequisites

- Docker installed and running
- Claude account or API key for authentication

## Quick Start

### Using the Pre-built Image

```bash
# Create profile directory for persistent storage
mkdir .claude-profile

# Run Claude Code in Docker
docker run -it --rm \
    --name claude-code \
    --userns=host \
    -u $(id -u):$(id -g) \
    -v $(pwd)/.claude-profile:/home/node \
    -v $(pwd):/workspace \
    -w /workspace \
    antonyho/claude-code
```

### Building Your Own Image

If you prefer to build the image yourself: (replace my namespace "antonyho" with yours)

```bash
# Build the image
docker build -t antonyho/claude-code .

# (Optional) Push to Docker Hub
docker push antonyho/claude-code
```

## How It Works

### First Launch Setup
On first launch, Claude Code will:
1. Ask for your theme preference
2. Prompt you to sign in with your Claude account or API key
3. Create a `CLAUDE.md` file in your current directory
4. Store authentication and session data in the `.claude-profile` directory

### Directory Structure
- `.claude-profile/` - Contains authentication tokens, session history, and user preferences (mounted to `/home/node` in container)
- Current directory - Mounted to `/workspace` for code access

*Consider to add `.claude-profile` directory to your project's `.gitignore` to keey your own Claude session in private.*

### Permission Handling
The Docker run command includes specific flags to handle file permissions:
- `--userns=host` - Disables user namespace isolation
- `-u $(id -u):$(id -g)` - Runs container with your host user/group IDs

This prevents permission issues when Claude Code creates files in mounted volumes.
**You are very likely that you don't need them if you have not configured user namespace on your Docker service.**
