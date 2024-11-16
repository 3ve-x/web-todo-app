FROM php:8.2-fpm

ENV LANG C.UTF-8
ENV COMPOSER_ALLOW_SUPERUSER 1

EXPOSE 5173

# PHP設定ファイルとApacheの設定をコピー
COPY php.ini /usr/local/etc/php/
COPY *.conf /etc/apache2/sites-enabled/

# Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - \
    && apt -y update \
    && apt -y upgrade \
    && apt -y install \
            git \
            libpq-dev \
            nodejs \
            unzip \
            zip \
            apache2  # Apache2のインストールを追加

# 必要なライブラリのインストール
RUN apt -y install \
            zlib1g-dev  \
            libheif-dev \
            libjpeg-dev \
            libpng-dev \
            libfreetype6-dev \
            libjpeg62-turbo-dev \
            librsvg2-dev \
            libwebp-dev \
            libxpm-dev \
            libmagickwand-dev \
            libzip-dev

# Imagickのインストール
RUN pecl install imagick \
    && docker-php-ext-enable imagick

# 必要なPHP拡張をインストール
RUN docker-php-ext-install pdo_pgsql zip

# Apacheのmod_rewriteを有効化
RUN a2enmod rewrite

# Composerのインストール
COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
