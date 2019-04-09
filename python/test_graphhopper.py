import unittest
import os
import graphhopper as gh

class GraphopperTests(unittest.TestCase):
    def setUp(self):
        base_url = os.environ.get("GH_API_URL") or "http://graphhopper:8989"
        self.api_client = gh.Graphhopper(base_url)

    def test_route(self):
        # Prepare
        from_lat = 52.553811
        from_lng = 13.371048
        to_lat = 52.526248
        to_lng = 13.368301

        # Act
        response = self.api_client.route(from_lat, from_lng, to_lat, to_lng)

        # Assert
        self.assertEqual(response.status_code, 200)

    def test_pointlist(self):
        # Prepare
        lat = 52.553811
        lng = 13.371048
        time_limit = 100

        # Act
        response = self.api_client.pointlist(lat, lng, time_limit)

        # Assert
        self.assertEqual(response.status_code, 200)

    def test_isochrone(self):
        # Prepare
        lat = 52.553811
        lng = 13.371048
        time_limit = 100
        buckets = 1

        # Act
        response = self.api_client.isochrone(lat, lng, time_limit, buckets)

        # Assert
        self.assertEqual(response.status_code, 200)

if __name__ == "__main__":
    unittest.main()

