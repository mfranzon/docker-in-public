# Use the official PHP image as the base image
FROM php:latest

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy the PHP application files to the container
COPY . .

# Install any necessary dependencies
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql

# Get environment variables
ARG author="Your name"
ARG version="1.0"

ARG mysql_host=localhost
ARG mysql_port=3306
ARG mysql_database=myapp
ARG mysql_user=root
ARG mysql_password=secret

# Set environment variables for configuration
ENV MYSQL_HOST=${mysql_host} \
    MYSQL_PORT=${mysql_port} \
    MYSQL_DATABASE=${mysql_database} \
    MYSQL_USER=${mysql_user} \
    MYSQL_PASSWORD=${mysql_password}

# Expose port 80 for the web server
EXPOSE 80

# Set a default command to run when the container starts
CMD ["php", "-S", "0.0.0.0:80"]

# Add labels for better maintainability
LABEL maintainer=${author}
LABEL version=${version}
LABEL description="Dockerfile for running a FastAPI application"