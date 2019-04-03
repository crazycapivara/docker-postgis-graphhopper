import requests

class Graphhopper(object):
    def __init__(self, base_url):
        self.base_url = base_url

    def route(self, from_lat, from_lng, to_lat, to_lng):
        params = {
            "point": [
                "%s,%s" % (from_lat, from_lng),
                "%s,%s" % (to_lat, to_lng)
            ],
            "instructions": False,
            "points_encoded": False
        }
        return self.response("route", params)

    def isochrone(self, lat, lng, time_limit, buckets):
        params = {
            "point": "%s,%s" % (lat, lng),
            "result": "polygon",
            "time_limit": time_limit,
            "buckets": buckets
        }
        return self.response("isochrone", params)

    def pointlist(self, lat, lng, time_limit):
        params = {
            "point": "%s,%s" % (lat, lng),
            "result": "pointlist",
            "time_limit": time_limit,
            "pointlist_ext_header": "prev_longitude,prev_latitude,node_id,prev_node_id"
        }
        return self.response("isochrone", params)

    def response(self, path, params):
        api_url = requests.compat.urljoin(self.base_url, path)
        response = requests.get(api_url, params = params)
        return response
    
