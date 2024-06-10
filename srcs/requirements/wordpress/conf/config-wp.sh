#!/bin/sh

if [ ! -f /var/www/wordpress/wp-config.php ]; then

	echo "wp-config.php file doesnt exists"

	cat << EOF > /var/www/wordpress/wp-config.php
<?php
define( 'DB_NAME', getenv('MYSQL_DATABASE') );
define( 'DB_USER', getenv('MYSQL_USER') );
define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') );

define( 'DB_HOST', getenv('MYSQL_HOST') );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname(__FILE__) . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF

	echo "wp-config.php created"
	#rm -f /var/www/wordpress/wp-config-sample.php
fi

#echo "Wordpress container started"
#/usr/sbin/php-fpm8 -F

