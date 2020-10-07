FROM php:7.4.3-cli-alpine3.10

COPY --from=composer:1.10.13 /usr/bin/composer /usr/local/bin/composer

ARG COMPOSER_REQUIRE_CHECKER_VERSION
RUN \
    apk update \
    && apk add --no-cache icu-dev libpng libpng-dev \
    # Not used by composer-require-checker, but to be compatible with a project who need it
    && docker-php-ext-install intl gd \
    && composer global require maglnet/composer-require-checker:${COMPOSER_REQUIRE_CHECKER_VERSION} \
    && ln -s /root/.composer/vendor/bin/composer-require-checker /usr/local/bin/composer-require-checker

WORKDIR "/app"

ENTRYPOINT ["php", "-d", "memory_limit=512M", "/root/.composer/vendor/bin/composer-require-checker"]
