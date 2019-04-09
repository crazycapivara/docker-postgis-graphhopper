CREATE OR REPLACE FUNCTION graphhopper.way (
  lat double precision,
  lng double precision,
  time_limit integer
)
RETURNS TABLE (
  target_id integer,
  source_id integer,
  way geometry,
  "time" double precision,
  distance double precision
) 
AS $$
BEGIN
  RETURN QUERY
  SELECT
    pl.node_id AS target_id,
    pl.prev_node_id AS source_id,
    ST_SetSRID(ST_MakeLine(ST_MakePoint(pl.lng, pl.lat), ST_MakePoint(pl.prev_lng, pl.prev_lat)), 4326) AS way,
    pl."time",
    pl.distance
  FROM graphhopper.pointlist(lat, lng, time_limit) AS pl;
END
$$ LANGUAGE plpgsql;

