include .env

start: init build install

init:
	sh init.sh

build:
	docker-compose up -d --build

dev:
	docker-compose up -d

restart: down dev

down:
	docker-compose down -v

clean: down
	@echo "💥 Removing related folders/files..."
	@rm -rf  core/*

reset: clean	

install: configure

configure:

	@echo "⚙️ Configuring Wordpress parameters..."
	@while ! docker-compose exec wordpress ls /var/www/html/wp-config.php > /dev/null 2>&1; do \
		echo "Waiting for WordPress to be fully initialized..."; \
		sleep 5; \
	done
	docker-compose exec wordpress wp core multisite-install \
		--title='${WP_SITE_TITLE}' \
		--admin_user='${WP_ADMIN_USER}' \
		--admin_password='${WP_ADMIN_PASSWORD}' \
		--admin_email='${WP_ADMIN_EMAIL}' \
		--allow-root