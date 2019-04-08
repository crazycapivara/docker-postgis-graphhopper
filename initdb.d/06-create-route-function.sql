CREATE OR REPLACE FUNCTION graphhopper.route (
  from_lat double precision,
  from_lng double precision,
  to_lat double precision,
  to_lng double precision
)
RETURNS TABLE (
  route jsonb,
  "time" double precision,
  distance double precision
) 
AS $$
  import os
  import sys
  import json

  sys.path.append("/python-libs")
  import graphhopper as gh

  base_url = os.environ.get("GH_API_URL") or "http://graphhopper:8989/"
  api_client = gh.Graphhopper(base_url)
  response = api_client.route(from_lat, from_lng, to_lat, to_lng)
  data = response.json()
  plpy.notice(response.url)
  path = data["paths"][0]
  return [ (json.dumps(path["points"]), path["time"], path["distance"]) ]
$$ LANGUAGE plpython3u;

