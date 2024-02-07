FROM nginx:stable-alpine

# ARG DOMAIN_NAME

ADD ./default.conf /etc/nginx/conf.d/default.conf
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./sites-available/ /etc/nginx/sites-available/

ADD ./certs/*.pem /etc/nginx/certs/

RUN mkdir -p /var/www/html