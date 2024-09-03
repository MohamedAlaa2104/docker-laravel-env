FROM composer:2

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

# The MacOS staff group gid is 20, so is the dialout group in alpine linux. We're not using it, so we're just going to remove it.
RUN delgroup dialout

RUN addgroup -g ${GID} --system laravel
RUN adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel

# Ensure necessary directories exist
RUN mkdir -p ./var/www/html/storage ./var/www/html/bootstrap/cache

# Set the correct permissions
RUN chown -R www-data:www-data ./var/www/html/storage ./var/www/html/bootstrap/cache
RUN chmod -R 775 ./var/www/html/storage ./var/www/html/bootstrap/cache
