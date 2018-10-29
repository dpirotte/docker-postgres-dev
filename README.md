# docker-postgres-dev

[![stars](https://img.shields.io/docker/stars/dpirotte/postgres-dev.svg)](https://hub.docker.com/r/dpirotte/postgres-dev/)
[![pulls](https://img.shields.io/docker/pulls/dpirotte/postgres-dev.svg)](https://hub.docker.com/r/dpirotte/postgres-dev/)
[![pulls](https://img.shields.io/docker/automated/dpirotte/postgres-dev.svg)](https://hub.docker.com/r/dpirotte/postgres-dev/builds/)
[![pulls](https://img.shields.io/docker/build/dpirotte/postgres-dev.svg)](https://hub.docker.com/r/dpirotte/postgres-dev/builds/)
[![Build Status](https://travis-ci.org/dpirotte/docker-postgres-dev.svg?branch=master)](https://travis-ci.org/dpirotte/docker-postgres-dev)

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

Servers and development headers for Postgres 9.3, 9.4, 9.5, 9.6, 10, and 11 are included.

# Usage

This image was designed to make it easier to build and test Postgres extensions against multiple versions of Postgres.

For example, in your `Makefile`, you can use an environment variable (e.g. `PG_VERSION`) to find the right version of `pg_config`. Then, you can run something like the following to test your extension:

```
docker run \
  --rm -it \
  -e PG_VERSION=11 \
  -v ${PWD}:/build \
  -w /build \
  dpirotte/postgres-dev:stretch \
  bash -c "pg_ctlcluster 11 main start ; make clean install installcheck"
```
