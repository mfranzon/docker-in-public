# Use the official Node.js image as the base image
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
ARG port=80
ARG vue_url=http://localhost:3000
ARG author="Your name"
ARG version="1.0"

# Build the Vue application
RUN npm run build

# Set the environment variable for the Vue application
ENV VUE_APP_API_URL=${vue_url}

# Expose the port that the Vue application will run on
EXPOSE ${port}

# Start the Vue application
CMD ["npm", "run", "serve"]

# Add labels for better maintainability
LABEL maintainer=${author}
LABEL version=${version}
LABEL description="Dockerfile for running a Vue.js application"