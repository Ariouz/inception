rc-service mysql start;
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "CRATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY \`$MY{SQL_PASSWORD}\`;"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY \`${MYSQL_ROOT_PASSWORD}\`;"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
exec mysqld_safe
