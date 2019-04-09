CREATE TABLE graphhopper.points_berlin (
  id SERIAL,
  geom geometry,
  lng double precision,
  lat double precision
);

DO $$
DECLARE
  x double precision[];
  y double precision[] := array[
    [13.394394, 52.514549],
    [13.399887, 52.536691],
    [13.42804, 52.494487],
    [13.41465, 52.591786],
    [13.155098, 52.549845],
    [13.226166, 52.411634],
    [13.580475, 52.39781]
  ];
BEGIN
  FOREACH x SLICE 1 IN ARRAY y
  LOOP
    INSERT INTO graphhopper.points_berlin (geom, lng, lat)
    VALUES (ST_SetSRID(ST_MakePoint(x[1], x[2]), 4326), x[1], x[2]);
  END LOOP;
END $$;

