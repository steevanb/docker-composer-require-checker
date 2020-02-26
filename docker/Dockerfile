FROM php:7.4.3-cli-alpine3.10

COPY --from=composer:1.9.3 /usr/bin/composer /usr/local/bin/composer

ARG COMPOSER_REQUIRE_CHECKER_VERSION
RUN \
    composer global require maglnet/composer-require-checker:${COMPOSER_REQUIRE_CHECKER_VERSION} \
    && ln -s /root/.composer/vendor/bin/composer-require-checker /usr/local/bin/composer-require-checker

WORKDIR "/app"

ENTRYPOINT ["php", "-d", "memory_limit=512M", "/root/.composer/vendor/bin/composer-require-checker"]
