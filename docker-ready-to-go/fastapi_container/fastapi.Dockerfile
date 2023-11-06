# Use the official Python base image
FROM python:latest

# Get environment variables
ARG app_port=8000
ARG author="Your name"
ARG version="1.0"

ENV APP_HOST=0.0.0.0
ENV APP_PORT=${app_port}

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the working directory
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the working directory
COPY . .

# Expose the port on which the application will run
EXPOSE ${APP_PORT}

# Set the entrypoint command to run the FastAPI application
CMD ["uvicorn", "main:app", "--host", "${APP_HOST}", "--port", "${APP_PORT}"]

# Add labels for better maintainability
LABEL maintainer=${author}
LABEL version=${version}
LABEL description="Dockerfile for running a FastAPI application"