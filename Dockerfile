# ### base
FROM postgres:10 AS base

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

# ### H3
FROM base AS h3

ENV BUILD_TOOLS "cmake make gcc libtool git pgxnclient postgresql-server-dev-$PG_MAJOR"

RUN apt-get install -y --no-install-recommends $BUILD_TOOLS

RUN pgxn install h3

RUN apt-get purge -y --auto-remove $BUILD_TOOLS

