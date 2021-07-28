FROM php:7.4.19-fpm
LABEL Maintainer="Filippo Esposto <3innovaweb@gmail.com>" \
      Description="Container with PHP 7.4 and Ansible for application deployments based on Ubuntu"

RUN apt-get update \
  && apt-get install -y \
    cron \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libxslt1-dev \
    libmagickwand-dev \
    unzip \
    iproute2 \
    sudo \
    git \
    libzip-dev

RUN docker-php-ext-configure \
  gd --with-freetype --with-jpeg

RUN docker-php-ext-install -j$(nproc)  \
  bcmath \
  gd \
  intl \
  pdo_mysql \
  soap \
  xsl \
  zip \
  opcache \
  sockets

RUN pecl install imagick
# install composer and "dependencies"
RUN apt-get install -y wget unzip
COPY install-composer.sh /root/install-composer.sh
RUN sh /root/install-composer.sh

# install npm & gulp
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install -y nodejs
RUN npm install -g gulp-cli

# oh, we need git and the ssh client too...
RUN apt-get install -y git openssh-client

# install ansible from a package too
RUN apt-get install -y ansible
# clear apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "memory_limit = 512M" > /usr/local/etc/php/conf.d/memory-limit.ini

# done
