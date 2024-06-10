FROM alpine:3.16

RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client
RUN apk add --no-cache openrc

RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel

RUN rc-service mariadb setup

COPY conf/sql-config.sh /tmp/sql-config.sh
RUN chmod +xw /tmp/sql-config.sh

EXPOSE 3306

CMD ["/tmp/sql-config.sh"]
