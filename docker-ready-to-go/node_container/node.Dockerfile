# Use the official Node.js latest image as the base image
FROM node:latest

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Get environment variables for configuration from input
ARG port=3000
ARG node_env=production
ARG author="Your name"
ARG version="1.0"

ENV PORT=${port}
ENV NODE_ENV=${node_env}

# Expose the port on which the application will listen
EXPOSE ${port}

# Set a default command to run the application
CMD ["node", "index.js"]

# Add labels for better maintainability
LABEL maintainer=${author}
LABEL version=${version}
LABEL description="Dockerfile for running a Node.js application"