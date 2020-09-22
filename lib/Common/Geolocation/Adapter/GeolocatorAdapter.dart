import 'dart:async';

import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart' as AdapterPlacemark;
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart' as AdapterPosition;
import 'package:injectable/injectable.dart';

abstract class GeolocatorAdapter {
  getCurrentPosition();

  Future<double> distanceBetween(double latitude, double longitude, double latitude2,
      double longitude2);

  placemarkFromPosition(Position searchPosition, {String localeIdentifier});

  Stream<Position> userPosition;

  startStreamCurrentPosition();
}
@Injectable(as: GeolocatorAdapter)
class GeolocatorAdapterImpl implements GeolocatorAdapter {
  Geolocator.Geolocator _geolocator = Geolocator.Geolocator();

  StreamController _fUserCurrentPositionStreamController;

  GeolocatorAdapterImpl(){
    _fUserCurrentPositionStreamController = StreamController<Position>.broadcast();
    userPosition = _fUserCurrentPositionStreamController.stream;
  }

  @override
  Future<AdapterPosition.Position> getCurrentPosition() async {
    Geolocator.Position position = await _geolocator.getCurrentPosition()
        .timeout(Duration(seconds: 20));
    _fUserCurrentPositionStreamController.add(Position.fromMap(position.toJson()));
    AdapterPosition.Position adapterPosition = AdapterPosition.Position.fromMap(
        position.toJson());
    return adapterPosition;
  }

  @override
   Future<double> distanceBetween(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return await _geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  @override
  Future<List<AdapterPlacemark.Placemark>> placemarkFromPosition(
      AdapterPosition.Position searchPosition,
      {String localeIdentifier}) async {
    Geolocator.Position position = Geolocator.Position.fromMap(
        searchPosition.toJson());
    List<Geolocator.Placemark> plcaemarks = await _geolocator
        .placemarkFromPosition(position, localeIdentifier: localeIdentifier);
    List<AdapterPlacemark.Placemark> adatperPlaceMarkers = [];
    plcaemarks.forEach((element) {
      adatperPlaceMarkers.add(
          AdapterPlacemark.Placemark.fromMap(element.toJson()));
    });
    return adatperPlaceMarkers;
  }


  startStreamCurrentPosition() {

    var locationOptions = Geolocator.LocationOptions(
        accuracy: Geolocator.LocationAccuracy.high,
        distanceFilter: _distanceFilter,
        forceAndroidLocationManager: true);
    _geolocator.getPositionStream(locationOptions).listen((Geolocator.Position event) {
      _fUserCurrentPositionStreamController.add(Position.fromMap(event.toJson()));
    });

  }

  int _distanceFilter = 5;

  @override
  Stream<Position> userPosition;

  dispose(){
    _fUserCurrentPositionStreamController.close();
  }
}