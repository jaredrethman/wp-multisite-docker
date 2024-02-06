include .env

start: wp-install certs build wait-for-mysql wait-for-wp install

certs:
	sh ./cli/create-certs.sh

wp-install:
	sh ./cli/wp-install.sh

remove-wp:
	@if [ -d "html/wp-includes" ]; then \
		echo "\n🚨 This will delete the WordPress file system, continue? (y/N)\n" && read ans && [ $$ans = y ] || exit 1; \
		rm -rf ./html/*.* ./html/wp-includes/ ./html/wp-admin/; \
	fi

remove-mysql:
	@if [ -d "mysql" ]; then \
		echo "\n🚨 This will delete the MySQL database, continue? (y/N)\n" && read ans && [ $${ans:-N} = y ] || exit 1; \
		rm -rf mysql; \
	fi

build:
	docker-compose up -d --build >/dev/null 2>&1

dev:
	docker-compose up -d

down:
	docker-compose down -v

restart: down dev

rebuild: down build

clean: down remove-wp remove-mysql

install:
	@echo "\n🕒 Installing WordPress Multisite..."
	@docker-compose exec php wp core multisite-install \
		--title=${WP_SITE_TITLE} \
		--admin_user='${WP_ADMIN_USER}' \
		--admin_password='${WP_ADMIN_PASSWORD}' \
		--admin_email='${WP_ADMIN_EMAIL}' \
		--allow-root > /dev/null 2>&1
	@echo "✔ Done!\n"

wait-for-mysql:
	@echo "\n🕒 Waiting for MySQL..."
	@until docker-compose exec mariadb mysql --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} --execute="USE ${MYSQL_DATABASE};" > /dev/null 2>&1; do \
		sleep 5; \
	done
	@echo "✔ Done!\n"

wait-for-wp:
	@echo "\n🕒 Waiting for WordPress installation..."
	@while ! docker-compose exec php ls /var/www/html/wp-config.php > /dev/null 2>&1; do \
		sleep 5; \
	done
	@echo "✔ Done!\n"