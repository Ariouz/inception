FROM alpine:3.16

RUN apk update && apk upgrade
RUN apk add mariadb mariadb-client openrc

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY conf/sql-config.sh /usr/local/bin/sql-config.sh

EXPOSE 3306

RUN chmod +x /usr/local/bin/sql-config.sh

CMD ["sh", "/usr/local/bin/sh sql-config.sh"]
