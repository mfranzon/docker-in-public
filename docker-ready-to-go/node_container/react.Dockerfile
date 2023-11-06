# Use an official Node.js runtime as the base image
FROM node:latest

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Get environment variables for configuration from input
ARG port=3000
ARG react_default_value
ARG author="Your name"
ARG version="1.0"

ENV REACT_APP_API_URL=${react_url}

# Expose the port that the React application will run on
EXPOSE ${port}

# Start the React application
CMD ["npm", "start"]

# Add labels for better maintainability
LABEL maintainer=${author}
LABEL version=${version}
LABEL description="Dockerfile for running a React.js application"