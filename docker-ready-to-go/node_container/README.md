# Node.js based containers

In this folder you will find the Dockerfile templates for immediatly deploy your JS web application.

Each Dockerfile have some customizable environment variables that you can set in the building phase.
For example:

```bash
docker build --build-arg author="yourName" .
```

Each Dockerfile is build to be ready to work with the differents JS framework. For example to build the Svelte image you can run this command:

```bash
docker build -f svelte.Dockerfile --build-arg \
port=5000 \ 
node_env="production" \
author="Me" .
```