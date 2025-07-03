# Claude Code in Docker container

## Build the iamge and push to Docker repository
(You don't have to do this if you feel safe to use my image on Docker Hub)

Building image and push to private Docker Hub account.
```
docker build -t antonyho/claude-code .
docker push antonyho/claude-code
```


## Sign in with Claude Account or API key
On first launch, Claude Code will ask for your theme preference and to sign into the Claude account or to use API key.
It will then create a `CLAUDE.md` file into your current directory. 

You should check the user of your Docker service. When you have user namespace enabled on your Docker configuration, the user inside the container might not be able to write file to the mounted volume. Using `--userns=host` to disable user namespace for this container, along with `-u $(id -u):$(id -g)` could possibly solve the permission problem.

This is a very specific directory needed to start using Claude Code. Because it will create files to home directory to store account information and session history. Since we are using Claude Code within Docker container, we need to create a dedicated directory within the project workspace and mount it to home directory of the Docker user inside container. After the first launch, the session and access token will be stored in this directory.

Here we create a directory call `.claude-profile` in current project workspace and mount it later. Consider to add this directory to `.gitignore`.
```
mkdir .claude-profile
```

Start the container.
```
docker run -it --rm \
    --name claude-code \
    --userns=host \
    -u $(id -u):$(id -g) \
    -v $(pwd)/.claude-profile:/home/node \
    -v $(pwd):/workspace \
    -w /workspace \
    antonyho/claude-code
```
