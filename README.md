## Docker image for maglnet/composer-require-checker

[ComposerRequireChecker](https://github.com/maglnet/ComposerRequireChecker)
is a tool to analyse composer dependencies and verify that no unknown symbols are used in the sources of a package.

As they said in their documentation, this tool should not be installed as dependency of your project.

So to use it you could install the phar version, or use this Docker image.

## Use the Docker image

Create a container from `steevanb/composer-require-checker` image and add a volume with your code into `/app` directory inside the container.
```bash
docker run --tty --rm --volume $(pwd):/app:ro steevanb/composer-require-checker:3.2.0
```

## Use it with CircleCI

```yaml
version: '2.1'

jobs:
    composer:
        docker:
            - image: composer
        working_directory: /app
        steps:
            - checkout
            - restore_cache:
                  key: vendor-{{ checksum "composer.json" }}-{{ checksum "composer.lock" }}
            - run:
                composer install --ignore-platform-reqs --no-interaction;
            - save_cache:
                  key: vendor-{{ checksum "composer.json" }}-{{ checksum "composer.lock" }}
                  paths:
                      - ./vendor
            - persist_to_workspace:
                  root: .
                  paths:
                      - vendor

    composerRequireChecker:
        docker:
            - image: steevanb/composer-require-checker:3.2.0
        working_directory: /app
        steps:
            - checkout
            - restore_cache:
                key: vendor-{{ checksum "composer.json" }}-{{ checksum "composer.lock" }}
            - run:
                name: composer-require-checker
                command: composer-require-checker

workflows:
    version: '2.1'
    CI:
        jobs:
            - composer
            - composerRequireChecker:
                requires:
                    - composer
```
