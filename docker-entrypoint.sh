#!/bin/sh
set -e

if [ ! -z "$PG_VERSION" ]; then
  echo inside
  echo $PG_VERSION
  pg_ctlcluster $PG_VERSION main start
fi

exec $*
