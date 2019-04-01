CREATE OR REPLACE FUNCTION graphhopper.test(
  )
  RETURNS TABLE(gh_api_url character varying) 
  LANGUAGE 'plpython3u'

  COST 100
  VOLATILE 
  ROWS 1000
AS $BODY$

import os

gh_api_url = os.environ.get("GH_API_URL") or "http://localhost:8989/"
return (gh_api_url, )

$BODY$;

