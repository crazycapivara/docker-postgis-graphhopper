FROM postgres:10

LABEL maintainer="Stefan Kuethe <crazycapivara@gmail.com>"

ENV POSTGIS_MAJOR 2.5

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    postgis \
    postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
    postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \
    python3 \
    python3-requests \
    postgresql-plpython3-$PG_MAJOR

COPY ./python /python-libs
COPY ./initdb.d /docker-entrypoint-initdb.d/
COPY ./examples /examples

