#!/bin/sh

while ! mariadb -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE &>/dev/null; do
	echo "Waiting for sql connection..."
	echo "host $MYSQL_HOST user $MYSQL_USER pass $MYSQL_PASSWORD base $MYSQL_DATABASE"
	sleep 3
done

if [ ! -f "/var/www/wordpress/index.php" ]; then

	cd /var/www/wordpress
	wp core download --path="/var/www/wordpress" --allow-root
	wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOST" --dbcharset="utf8" --dbcollate="utf8_general_ci" --dbprefix="wp_" --allow-root
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
fi

echo "Started wordpress"
/usr/sbin/php-fpm8 -F -R
