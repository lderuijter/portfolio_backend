# Use an official PHP runtime as the base image
FROM php:8.4.4-fpm-alpine

# Install system dependencies and PHP extensions
RUN apk update && apk add --no-cache \
    libpng-dev libjpeg-turbo-dev freetype-dev \
    libzip-dev unzip git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_sqlite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory in the container
WORKDIR /var/www

# Copy the composer.json and install dependencies
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

# Copy the rest of the application code
COPY . .

# Expose port 9000 for the PHP-FPM server
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
