# Use PHP with Apache
FROM php:8.4.4-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev freetype-dev \
    libzip-dev unzip git sqlite3 libsqlite3-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_sqlite

# Enable Apache mod_rewrite for Laravel
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www

# Copy Laravel files
COPY . .

# Set proper permissions
RUN chown -R www-data:www-data /var/www

# Set Laravel's public folder as Apache DocumentRoot
RUN sed -i 's|/var/www/html|/var/www/public|g' /etc/apache2/sites-available/000-default.conf

# Expose Apache's default port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
