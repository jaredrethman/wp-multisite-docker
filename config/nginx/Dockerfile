FROM nginx:stable-alpine

ARG DOMAIN_NAME

ADD ./default.conf /etc/nginx/conf.d/default.conf
RUN sed -i -r "s/localhost/${DOMAIN_NAME}/g" /etc/nginx/conf.d/default.conf

ADD ./certs/${DOMAIN_NAME}.pem /etc/nginx/certs/${DOMAIN_NAME}.pem
ADD ./certs/${DOMAIN_NAME}-key.pem /etc/nginx/certs/${DOMAIN_NAME}-key.pem

RUN mkdir -p /var/www/html