FROM php:8.0.3-cli-alpine3.13

COPY --from=composer:2.0.12 /usr/bin/composer /usr/local/bin/composer

ARG COMPOSER_REQUIRE_CHECKER_VERSION
RUN \
    apk update \
    && apk add --no-cache icu-dev libpng libpng-dev \
    && composer global require maglnet/composer-require-checker:${COMPOSER_REQUIRE_CHECKER_VERSION} \
    && ln -s /root/.composer/vendor/bin/composer-require-checker /usr/local/bin/composer-require-checker

WORKDIR "/app"

ENTRYPOINT ["php", "-d", "memory_limit=512M", "/usr/local/bin/composer-require-checker"]
