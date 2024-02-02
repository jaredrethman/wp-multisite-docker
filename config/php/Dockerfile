# Use the official WordPress image as a parent image
ARG WP_IMAGE
FROM ${WP_IMAGE}

# Download WP-CLI
RUN apt-get update && apt-get install -y curl \
    && curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp