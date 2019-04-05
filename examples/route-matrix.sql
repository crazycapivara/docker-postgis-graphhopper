WITH routes AS (
  SELECT
    a.id AS source_id,
    b.id AS target_id,
    (SELECT row_to_json(r) FROM graphhopper.route(ST_Y(a.geom), ST_X(a.geom), ST_Y(b.geom), ST_X(b.geom)) AS r) AS route
    FROM graphhopper.points_berlin AS a
      CROSS JOIN graphhopper.points_berlin AS b
    WHERE a.id IN (3, 4)
)

SELECT
  source_id,
  target_id,
  -- ST_SetSRID(ST_geomFromGeoJSON(route->'route'), 4326) AS linestring,
  cast(route->>'time' as integer) AS "time",
  cast(route->>'distance' as double precision) AS distance
  FROM routes

