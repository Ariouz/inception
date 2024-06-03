FROM alpine:3.16

RUN apk update && apk upgrade && \
	apk add --no-cache openrc php8 php8-fpm php8-mysqli php8-openssl wget

RUN mkdir -p /var/www/ \
	&& cd /var/www/ \
	&& wget https://wordpress.org/latest.tar.gz \
	&& tar -xzvf latest.tar.gz \
	&& rm latest.tar.gz
RUN chown -R root:root /var/www/wordpress

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
	/etc/php8/php-fpm.d/www.conf && \
	sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
	/etc/php8/php-fpm.d/www.conf && \
	sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
	/etc/php8/php-fpm.d/www.conf

#EXPOSE 9000
CMD ["/usr/sbin/php-fpm8", "-F"]
