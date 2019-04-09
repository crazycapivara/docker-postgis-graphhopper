CREATE OR REPLACE FUNCTION graphhopper.isochrone (
  lat double precision,
  lng double precision,
  time_limit integer DEFAULT 200,
  buckets integer DEFAULT 1
)
RETURNS TABLE (isochrone jsonb)
AS $$
  import os
  import sys
  import json

  sys.path.append("/python-libs")
  import graphhopper as gh

  base_url = os.environ.get("GH_API_URL") or "http://graphhopper:8989/"
  api_client = gh.Graphhopper(base_url)
  response = api_client.isochrone(lat, lng, time_limit, buckets)
  data = response.json()
  plpy.notice(response.url)
  return [json.dumps(item["geometry"]) for item in data["polygons"]]
$$ LANGUAGE plpython3u;

