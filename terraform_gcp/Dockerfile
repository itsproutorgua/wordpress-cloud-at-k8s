FROM alpine:3.14
# Install Mysql Client
RUN apk add --no-cache mysql-client
RUN mkdir -p /var/www/html/ && chmod 777 /var/www/html/
# Install dependencies for WP-CLI
RUN apk add --no-cache \
        less \
        php7 \
        php7-curl \
        php7-json \
        php7-mbstring \
        php7-mysqli \
        php7-phar \
        php7-openssl \
        php7-dom \
        php7-xml \
        php7-xmlwriter \
        php7-simplexml
# Download and Install WP-CLI
RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp
# Set the server name and login credentials
ENV SERVER_NAME mysql
ENV USER_NAME root
ENV PASSWORD wordsec
# Implemented scripts
COPY scripts/setup-db-wp.sh /usr/local/bin/setup-db-wp.sh
RUN chmod +x /usr/local/bin/setup-db-wp.sh /usr/local/bin/setup-db-wp.sh
# Install entrypoint for setup-db-wp.sh
ENTRYPOINT ["/usr/local/bin/setup-db-wp.sh"]
