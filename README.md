# docker-postgis-graphhopper

[![Travis-CI Build Status](https://travis-ci.org/crazycapivara/docker-postgis-graphhopper.svg?branch=master)](https://travis-ci.org/crazycapivara/docker-postgis-graphhopper)

Calls the [graphhopper](https://www.graphhopper.com) API from postgres/postgis!

```bash
docker-compose up -d

# Tests
docker exec -it pg-gh-postgis python3 /python-libs/test_graphhopper.py

docker exec -it pg-gh-postgis \
  psql -U postgres -c 'SELECT * FROM graphhopper.pointlist(52.553811, 13.371048, 60) LIMIT 5'

docker exec -it pg-gh-postgis \
  psql -U postgres -c 'SELECT time, distance FROM graphhopper.route(52.553811, 13.371048, 52.526248, 13.368301)'

docker exec -it pg-gh-postgis psql -U postgres -f /examples/route-matrix.sql

docker exec -it pg-gh-postgis \
  psql -U postgres -c 'SELECT DISTINCT h3_geo_to_h3(ST_MakePoint(lng, lat), 7) FROM graphhopper.pointlist(52.514549, 13.394394)'

docker exec -it pg-gh-postgis \
  psql -U postgres -c 'SELECT h3_index, time, distance FROM graphhopper.h3_hexagons(52.514549, 13.394394, 9) LIMIT 5'
```

