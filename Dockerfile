FROM ubuntu:18.04
LABEL Maintainer="Luis Lopes <luis@bitok.pt>" \
      Description="Container with PHP 7.1 and Ansible for application deployments based on Ubuntu"

ENV PHP_VERSION 7.1

# add php ppa
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:ondrej/php -y

# install php7.1
RUN apt-get install -y php$PHP_VERSION-common php$PHP_VERSION-cli php$PHP_VERSION-bcmath php$PHP_VERSION-intl php$PHP_VERSION-curl php$PHP_VERSION-gd php$PHP_VERSION-soap php$PHP_VERSION-json php$PHP_VERSION-mcrypt php$PHP_VERSION-zip php$PHP_VERSION-mbstring php$PHP_VERSION-mysql php$PHP_VERSION-xml php$PHP_VERSION-imagick

# install ansible from a package too
RUN apt-get install -y ansible

# install composer
COPY install-composer.sh /root/install-composer.sh
RUN sh /root/install-composer.sh

# done
