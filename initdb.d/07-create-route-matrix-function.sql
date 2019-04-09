CREATE OR REPLACE FUNCTION graphhopper.route_matrix (tbl regclass)
RETURNS TABLE (
  start_id integer,
  end_id integer,
  route jsonb,
  "time" double precision,
  distance double precision
)
AS $$
  DECLARE target RECORD;
  BEGIN
    FOR target IN EXECUTE format (
      'SELECT
         pts.id AS id, ST_Y(pts.geom) AS lat, ST_X(pts.geom) AS lng,
         pts2.id AS id2, ST_Y(pts2.geom) AS lat2, ST_X(pts2.geom) AS lng2
       FROM %s AS pts
         CROSS JOIN %s AS pts2', tbl, tbl
    )
    LOOP
      RETURN QUERY
      SELECT target.id, target.id2, res.route, res.time, res.distance
      FROM graphhopper.route(target.lat, target.lng, target.lat2, target.lng2) AS res;
    END LOOP;
  END
$$ language plpgsql;

