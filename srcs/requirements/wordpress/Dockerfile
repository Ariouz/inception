FROM alpine:3.16

RUN apk update && apk upgrade && \
	apk add --no-cache openrc \
	mariadb-client \
	php8 \
	php8-fpm \
	php8-bcmath \
	php8-bz2 \
	php8-calendar \
	php8-ctype \
	php8-curl \
	php8-dom \
	php8-exif \
	php8-fileinfo \
	php8-gd \
	#php8-imagick \
	php8-gmp \
	php8-iconv \
	php8-imap \
	php8-intl \
	php8-json \
	php8-mbstring \
	#php7-mcrypt \
	#php7-memcache \
	php8-mysqlnd \
	php8-pcntl \
	php8-pdo \
	php8-pdo_mysql \
	php8-pdo_pgsql \
	php8-pdo_sqlite \
	php8-pgsql \
	php8-phar \
	php8-posix \
	php8-session \
	php8-shmop \
	php8-simplexml \
	php8-soap \
	php8-sockets \
	php8-sodium \
	php8-sqlite3 \
	php8-sysvsem \
	php8-sysvshm \
	php8-tokenizer \
	php8-xml \
	php8-xmlreader \
	php8-xmlwriter \
	php8-xsl \
	php8-zip \
	php8-zlib \
	php8-mysqli \
	php8-openssl \
	wget \
	tar

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
	/etc/php8/php-fpm.d/www.conf && \
	sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
	/etc/php8/php-fpm.d/www.conf && \
	sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
	/etc/php8/php-fpm.d/www.conf

COPY conf/config.sh /tmp/config.sh
RUN chmod 755 /tmp/config.sh

#COPY conf/config-wp.sh /tmp/config-wp.sh
#RUN chmod 755 /tmp/config-wp.sh

#RUN mkdir -p /var/www/wordpress
#COPY conf/wp-config.php /var/www/wordpress/wp-config.php

#EXPOSE 9000
CMD ["sh", "/tmp/config.sh"]
