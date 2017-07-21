#!/bin/sh
set -e

if [ ! -z "$PG_VERSION" ]; then
  pg_ctlcluster $PG_VERSION main start
fi

exec $*
