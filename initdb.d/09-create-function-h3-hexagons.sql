CREATE OR REPLACE FUNCTION graphhopper.h3_hexagons (
  lat double precision,
  lng double precision,
  resolution integer
)
RETURNS TABLE (
  h3_index h3index,
  "time" double precision,
  distance double precision,
  geom geometry
)
AS $$
  BEGIN
    RETURN QUERY
    WITH base AS (
      SELECT
        h3_geo_to_h3(ST_MakePoint(h.lng, h.lat), 9) AS h3_index,
        avg(h."time") AS "time",
        avg(h.distance) AS distance
      FROM graphhopper.pointlist(lat, lng) AS h GROUP BY h3_index
    )
    SELECT b.h3_index, b."time", b.distance, ST_SetSRID(h3_to_geo_boundary_geometry(b.h3_index), 4326) AS geom FROM base AS b;
  END
$$ LANGUAGE plpgsql;
