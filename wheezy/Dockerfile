FROM debian:wheezy

# PGDG repository
RUN apt-get -yqq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install wget ca-certificates lsb-release apt-utils gnupg2
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get -yqq update

# Postgresql development dependencies and runtime dependencies for installcheck
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install \
  postgresql-9.2 \
  postgresql-9.3 \
  postgresql-9.4 \
  postgresql-9.5 \
  postgresql-9.6 \
  postgresql-server-dev-all \
  ;

RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install \
  curl \
  gcc \
  git \
  make \
  ruby \
  ruby-dev \
  unzip \
  ;

RUN gem install fpm fpm-cookery --no-rdoc --no-ri

# It is more convenient to run installcheck if `root` has a user on the database
RUN for version in 9.2 9.3 9.4 9.5 9.6 ; do \
  pg_ctlcluster $version main start && \
  su postgres -c "createuser --cluster $version/main -d -r -s root" && \
  pg_ctlcluster $version main stop --force \
; done

# Enable logical decoding for 9.4+
RUN for version in 9.4 9.5 9.6 ; do \
  echo \
  "wal_level = logical\n" \
  "max_wal_senders = 5\n" \
  "max_replication_slots = 5\n" \
  >> /etc/postgresql/$version/main/postgresql.conf \
; done


