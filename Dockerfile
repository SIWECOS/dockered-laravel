FROM php:7.3-apache

LABEL maintainer="Sascha Brendel <mail@lednerb.eu>"

# Settings
ENV ARTISAN_GENERATE_KEY true
ENV ARTISAN_CACHE true
ENV ARTISAN_MIGRATE false

ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:de
ENV LC_ALL de_DE.UTF-8


# Install all dependencies and generate the locales
RUN apt-get update -y \
    && apt-get install -y redis-server libicu-dev openssl vim zip unzip git libpng-dev zlib1g-dev python3 python3-pip libzip-dev locales \
    && sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && sed -i 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl mysqli pdo_mysql pdo mbstring gd zip \
    && pip3 install supervisor \
    && pecl install -o -f redis \
    && docker-php-ext-enable redis \
    && apt-get clean \
    && rm -rf /tmp/pear \
    && rm -r /var/lib/apt/lists/*

# Change uid and gid of apache to docker user uid/gid
# Change the web_root to laravel /var/www/html/public folder
# Enable apache module rewrite
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data \
    && sed -i -e "s/html/html\/public/g" /etc/apache2/sites-enabled/000-default.conf \
    && a2enmod rewrite

# Copy configuration files
COPY php.ini /usr/local/etc/php/
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY startup.sh /

# Speedup composer
RUN composer global require hirak/prestissimo

WORKDIR /var/www/html

CMD /startup.sh

EXPOSE 80
