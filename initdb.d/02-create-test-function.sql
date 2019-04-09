CREATE OR REPLACE FUNCTION graphhopper.test ()
RETURNS TABLE (gh_api_url character varying) 
AS $$
  import os

  gh_api_url = os.environ.get("GH_API_URL") or "http://graphhopper:8989/"
  return (gh_api_url, )
$$ LANGUAGE plpython3u;

