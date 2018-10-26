# docker-postgres-dev

[![stars](https://img.shields.io/docker/stars/dpirotte/postgres-dev.svg)](https://hub.docker.com/r/dpirotte/postgres-dev/)
[![pulls](https://img.shields.io/docker/pulls/dpirotte/postgres-dev.svg)](https://hub.docker.com/r/dpirotte/postgres-dev/)
[![pulls](https://img.shields.io/docker/automated/dpirotte/postgres-dev.svg)](https://hub.docker.com/r/dpirotte/postgres-dev/builds/)
[![pulls](https://img.shields.io/docker/build/dpirotte/postgres-dev.svg)](https://hub.docker.com/r/dpirotte/postgres-dev/builds/)

Docker image useful for building Debian packages for Postgres extensions.

```
docker pull dpirotte/postgres-dev:stretch
```

This image includes the Postgres database server with development headers for all versions of Postgres in PGDG. It also includes [fpm](https://github.com/jordansissel/fpm) and [fpm-cookery](https://github.com/bernd/fpm-cookery) to easily create packages.

Tags correspond to the OS version.

|Distro|Version|Tag|
|------|-------|---|
|Debian|Jessie (8.x)|`jessie`|
|Debian|Stretch (9.x)|`stretch`, `latest`|
|Ubuntu|Trusty Tahr (14.04)|`trusty`|
|Ubuntu|Xenial Xerus (16.04)|`xenial`|
|Ubuntu|Bionic Beaver (18.04)|`bionic`|
