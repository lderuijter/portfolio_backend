# Use PHP with Apache
FROM php:8.4-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev unzip git sqlite3 libsqlite3-dev libonig-dev curl \
    && docker-php-ext-install zip pdo pdo_sqlite

# Enable Apache mod_rewrite for Laravel
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www

# Copy the entire Laravel project first
COPY . .

# Copy the example file to setup the environment
COPY .env.example .env

# Set proper permissions
RUN chown -R www-data:www-data /var/www

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Run Composer install (as www-data to avoid root issues)
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress

# Set Laravel's public folder as Apache DocumentRoot
RUN sed -i 's|/var/www/html|/var/www/public|g' /etc/apache2/sites-available/000-default.conf

# Expose Apache's default port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
