# Use the official Rust image as the base image
FROM rust:latest

# Get environment variables for configuration
ARG app_port=8080

ENV APP_PORT=${app_port}
ENV APP_HOST=0.0.0.0

# Set the working directory inside the container
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files to the working directory
COPY Cargo.toml Cargo.lock ./

# Build the dependencies of the Rust application
RUN cargo build --release

# Copy the source code to the working directory
COPY src ./src

# Build the Rust application
RUN cargo build --release

# Expose the port on which the application will listen
EXPOSE $APP_PORT

# Set the command to run the Rust application
CMD ["cargo", "run", "--release"]