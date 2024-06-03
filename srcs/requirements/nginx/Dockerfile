FROM alpine:3.16

RUN apk update && apk upgrade && apk add nginx
RUN mkdir -p /etc/nginx/ssl

COPY tools/inception.crt /etc/nginx/ssl/inception.crt
COPY tools/inception.key /etc/nginx/ssl/inception.key

RUN mkdir -p /var/run/nginx /var/www/html
COPY conf/nginx.conf /etc/nginx/http.d/default.conf
RUN chmod 755 /var/www/html
RUN chown -R nginx:nginx /var/www/html

CMD ["nginx", "-g", "daemon off;"]
