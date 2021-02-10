FROM httpd:2-alpine

ARG userid
ARG groupid

RUN sed -i 's|DocumentRoot.*|DocumentRoot "/var/www/html"|g' conf/httpd.conf
RUN echo 'Include "conf/wordpress-example.conf"' >> conf/httpd.conf

COPY wordpress-example.conf conf/wordpress-example.conf

RUN chown -hR $userid:$groupid /usr/local/apache2
