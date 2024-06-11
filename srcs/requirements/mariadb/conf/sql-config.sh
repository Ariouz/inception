#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	chmod 755 /run/mysqld
	{
		echo '[mysqld]'; \
		echo 'skip-host-cache'; \
		echo 'skip-name-resolve'; \
		echo 'bind-address=0.0.0.0'; \
		echo 'datadir=/var/lib/mysql'; \
		echo 'user=mysql'; \
		echo 'port=3306'; \
	} | tee /etc/my.cnf.d/docker.cnf
		
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then

	chown -R mysql:mysql /var/lib/mysql
	chmod 755 /var/lib/mysql
	/usr/bin/mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	file = 'mktemp'
	if [ ! -f "$file" ]; then
		return 1
	fi
fi

if [ ! -f "/var/lib/mysql/wordpress" ]; then

	cat << EOF > init.db
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE ${MYSQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
	echo "Creating wordpress database..."
	/usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap < init.db
	cat init.db
	rm -f init.db
fi

sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf
#sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

echo "Starting mariadb..."
exec mysqld_safe --user=mysql --console

