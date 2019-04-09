SELECT ST_Union(
  array(
    SELECT DISTINCT h3_to_geo_boundary_geometry(h3_geo_to_h3(ST_MakePoint(lng, lat), 10))
    FROM graphhopper.pointlist(52.514549, 13.394394)
  ) 
) AS isochrone

