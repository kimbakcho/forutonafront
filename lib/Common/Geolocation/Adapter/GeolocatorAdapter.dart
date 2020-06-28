import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart' as AdapterPlacemark;
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart' as AdapterPosition;

abstract class  GeolocatorAdapter {
  getCurrentPosition() {}

  distanceBetween(double latitude, double longitude, double latitude2, double longitude2);

  placemarkFromPosition(Position searchPosition, {String localeIdentifier});

}
class GeolocatorAdapterImpl implements GeolocatorAdapter {
  Geolocator.Geolocator _geolocator = Geolocator.Geolocator();

  @override
  Future<AdapterPosition.Position> getCurrentPosition() async {
    Geolocator.Position position = await _geolocator.getCurrentPosition();
    AdapterPosition.Position adapterPosition = AdapterPosition.Position.fromMap(position.toJson());
    return adapterPosition;
  }

  @override
  distanceBetween(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return _geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }

  @override
  Future<List<AdapterPlacemark.Placemark>> placemarkFromPosition(AdapterPosition.Position searchPosition, {String localeIdentifier}) async {
    Geolocator.Position position = Geolocator.Position.fromMap(searchPosition.toJson());
    List<Geolocator.Placemark> plcaemarks = await _geolocator.placemarkFromPosition(position,localeIdentifier:localeIdentifier );
    List<AdapterPlacemark.Placemark> adatperPlaceMarkers = [];
    plcaemarks.forEach((element) {
      adatperPlaceMarkers.add(AdapterPlacemark.Placemark.fromMap(element.toJson()));
    });
    return adatperPlaceMarkers;
  }

}