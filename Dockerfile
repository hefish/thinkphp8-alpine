FROM alpine:3.19

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories  &&  \
    apk update  && \
    apk add nginx php82-fpm  composer php82-pdo_mysql php82-opcache && \
    mkdir -p /var/www/html/public 


ADD config/nginx.conf  /etc/nginx/nginx.conf
ADD config/default.conf /etc/nginx/http.d/default.conf
ADD config/php.conf.d/99_php.ini /etc/php82/conf.d/99_php.ini
ADD entry_point.sh  /entry_point.sh
ADD index.php  /var/www/html/public/index.php

EXPOSE 80

VOLUME ["/var/www/html"]

CMD ["/entry_point.sh"]