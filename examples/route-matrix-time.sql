SELECT
  a.id AS source_id,
  b.id AS target_id,
  (SELECT "time" FROM graphhopper.route(ST_Y(a.geom), ST_X(a.geom), ST_Y(b.geom), ST_X(b.geom))) AS "time"
FROM graphhopper.points_berlin AS a
  CROSS JOIN graphhopper.points_berlin AS b
WHERE a.id IN (3, 4)

