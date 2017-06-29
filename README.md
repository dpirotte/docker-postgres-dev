# docker-postgres-dev

![stars](https://img.shields.io/docker/stars/dpirotte/postgres-dev.svg)
![pulls](https://img.shields.io/docker/pulls/dpirotte/postgres-dev.svg)
![pulls](https://img.shields.io/docker/automated/dpirotte/postgres-dev.svg)
![pulls](https://img.shields.io/docker/build/dpirotte/postgres-dev.svg)


Docker image useful for building Debian packages for Postgres extensions.

This image includes the Postgres database server with development headers for all versions of Postgres in PGDG. It also includes [fpm](https://github.com/jordansissel/fpm) and [fpm-cookery](https://github.com/bernd/fpm-cookery) to easily create packages.

Tags correspond to the OS version.

|Distro|Version|Tag|
|------|-------|---|
|Debian|Wheezy (7.x)|`wheezy`|
|Debian|Jessie (8.x)|`jessie`, `latest`|
|Debian|Stretch (9.x)|`stretch`|
|Ubuntu|Trusty Tahr (14.04)|`trusty`|
|Ubuntu|Xenial Xerus (16.04)|`xenial`|
