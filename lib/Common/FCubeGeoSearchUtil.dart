import 'package:forutonafront/Common/GeoSearchUtil.dart';

class FCubeGeoSearchUtil extends GeoSearchUtil {
  int cubestate;
  DateTime activationtime;
  int cubescope;

  FCubeGeoSearchUtil.fromGeoSearchUtil(
    GeoSearchUtil searchitem, {
    this.activationtime,
    this.cubescope,
    this.cubestate,
  }) {
    this.distance = searchitem.distance;
    this.latitude = searchitem.latitude;
    this.longitude = searchitem.longitude;
    this.offset = searchitem.offset;
    this.limit = searchitem.limit;
  }
  Map<String, dynamic> toJson() => {
        "distance": distance / 1000, // chage km
        "latitude": latitude,
        "longitude": longitude,
        "offset": offset,
        "limit": limit,
        "activationtime": activationtime.toIso8601String(),
        "cubescope": cubescope,
        "cubestate": cubestate,
      };
}
