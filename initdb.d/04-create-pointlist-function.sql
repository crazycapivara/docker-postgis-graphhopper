CREATE OR REPLACE FUNCTION graphhopper.pointlist (
  lat double precision,
  lng double precision,
  time_limit integer DEFAULT 200
)
RETURNS TABLE (
  lng double precision,
  lat double precision,
  "time" double precision,
  distance double precision,
  prev_lng double precision,
  prev_lat double precision,
  node_id integer,
  prev_node_id integer
)
AS $$
  import os
  import sys
  import json

  sys.path.append("/python-libs")
  import graphhopper as gh

  base_url = os.environ.get("GH_API_URL") or "http://graphhopper:8989/"
  api_client = gh.Graphhopper(base_url)
  response = api_client.pointlist(lat, lng, time_limit)
  data = response.json()
  plpy.notice(response.url)
  return data["items"]
$$ LANGUAGE plpython3u;

