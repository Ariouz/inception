FROM alpine:3.20.0
RUN apk add nginx
COPY conf /etc/nginx/sites-available/default
EXPOSE 80 443
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
