# vi: ft=dockerfile

FROM dpirotte/fpm-cookery:xenial

# PGDG repository
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
  lsb-release \
&& rm -rf /var/lib/apt/lists/*

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
  postgresql-common \
&& rm -rf /var/lib/apt/lists/*

RUN echo \
  "create_main_cluster = false\n" \
  "start_conf = 'manual'\n" \
>> /etc/postgresql-common/createcluster.conf

# Postgresql development dependencies and runtime dependencies for installcheck
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
  postgresql-9.3 \
  postgresql-9.4 \
  postgresql-9.5 \
  postgresql-9.6 \
  postgresql-10 \
  postgresql-11 \
  postgresql-9.3-pgtap \
  postgresql-9.4-pgtap \
  postgresql-9.5-pgtap \
  postgresql-9.6-pgtap \
  postgresql-10-pgtap \
  postgresql-11-pgtap \
  postgresql-server-dev-all \
&& rm -rf /var/lib/apt/lists/*

# Set en_US.UTF-8 as default encoding
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8

# It is more convenient to run installcheck if `root` has a user on the database
RUN for version in 9.3 9.4 9.5 9.6 10 11; do \
  pg_createcluster $version main && \
  sed -ri "s/port = [0-9]+/port = 5432/" /etc/postgresql/$version/main/postgresql.conf && \
  pg_ctlcluster $version main start && \
  su postgres -c "createuser --cluster $version/main -d -r -s root" && \
  pg_ctlcluster $version main stop --force \
; done

# Enable logical decoding for 9.4+
RUN for version in 9.4 9.5 9.6 10 11; do \
  echo \
  "wal_level = logical\n" \
  "max_wal_senders = 5\n" \
  "max_replication_slots = 5\n" \
  >> /etc/postgresql/$version/main/postgresql.conf \
; done

# Allow local replication connections in versions that don't enable by default
RUN for version in 9.4 9.5 9.6; do \
  echo \
  "local replication all peer\n" \
  "host replication all 127.0.0.1/32 md5\n" \
  "host replication all ::1/128 md5\n" \
  >> /etc/postgresql/$version/main/pg_hba.conf \
; done
