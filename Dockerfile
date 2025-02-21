# Use PHP with Apache
FROM php:8.4-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev unzip git sqlite3 libsqlite3-dev libonig-dev \
    && docker-php-ext-install zip pdo pdo_sqlite

# Enable Apache mod_rewrite for Laravel
RUN a2enmod rewrite

# Set working directory
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
