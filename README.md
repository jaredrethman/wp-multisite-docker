# WordPress Local Docker:
- LEMP: Linux, E/Nginx, MariaDB, PHP
- Version controlled `wp-content` directory

## Dependencies:
- Docker & Docker Compose
- (Optional) [mkcert](https://github.com/FiloSottile/mkcert) for cert management, alternatively, macOS is required

## Usage:
1. [Fork](https://github.com/jaredrethman/wp-multisite-docker/fork) or [Use this template](https://github.com/new?template_name=wp-multisite-docker&template_owner=jaredrethman)
2. Environment variables: Run `cp .env.example .env`, open `.env` and update `DOMAIN_NAME` and `WP_URL` with your desired domain
3. Build Environment: Run `make start`, this will:
   * Download and sync WordPress file system
   * Generate `wp-config.php` using variables from `.env` and adding extra config from [`./wp-config.txt`](https://github.com/jaredrethman/wp-multisite-docker/blob/main/wp-config.txt)
   * Generate certs, see section on certs
   * Build Docker containers specified in `docker-compose.yml`
   * Install WordPress db tables with details specified in `.env` i.e. `WP_ADMIN_USER` & `WP_ADMIN_PASSWORD`

### SSL Certs:
Currently there are two options when adding ssl:
1. (Recommended) Use [mkcert](https://github.com/FiloSottile/mkcert). Store using the following pattern `./config/nginx/certs/${DOMAIN_NAME}-key.pem` & `./config/nginx/certs/${DOMAIN_NAME}.pem`
2. OpenSSL cert generation. macOS only!

## Inspiration:
This project was heavily inspired by these two projects
- https://github.com/aschmelyun/docker-compose-wordpress/
- https://github.com/aurkenb/docker-wordpress-lemp
