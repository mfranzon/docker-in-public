# Use an official Node.js image as the base
FROM node:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Get environment variables for configuration from input
ARG port=5000
ARG node_env="production"
ARG svelte_url=http://localhost:3000
ARG author="Your name"
ARG version="1.0"

# Build the Svelte application
RUN npm run build

# Expose the port that the application will run on
EXPOSE $port

# Set the environment variables for configuration
ENV NODE_ENV=${node_env}
ENV PORT=5000

# Set a default value for the environment variable
ENV API_URL=${svelte_url}

# Start the application
CMD ["npm", "start"]

# Add labels for better maintainability
LABEL maintainer=${author}
LABEL version=${version}
LABEL description="Dockerfile for running a Node.js application"