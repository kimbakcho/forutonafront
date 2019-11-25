class GeoSearchUtil {
  double distance;
  double latitude;
  double longitude;
  int offset;
  int limit;

  GeoSearchUtil({
    this.distance,
    this.latitude,
    this.longitude,
    this.offset,
    this.limit,
  });

  Map<String, dynamic> toJson() => {
        "distance": distance / 1000, //change for km
        "latitude": latitude,
        "longitude": longitude,
        "offset": offset,
        "limit": limit,
      };
}
