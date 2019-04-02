import requests

class Graphhopper(object):
    def __init__(self, base_url):
        self.base_url = base_url

    def isochrone(self, lat, lng, time_limit, buckets):
        params = {
            "point": "%s,%s" % (lat, lng),
            "result": "polygon",
            "time_limit": time_limit,
            "buckets": buckets
        }
        api_url = requests.compat.urljoin(self.base_url, "isochrone")
        response = requests.get(api_url, params = params)
        return response

