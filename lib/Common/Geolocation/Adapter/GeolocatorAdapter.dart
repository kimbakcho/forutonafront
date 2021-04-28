import 'dart:async';

import 'package:forutonafront/Common/Geolocation/Data/Value/Placemark.dart' as AdapterPlacemark;
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart' as FPosition;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart' as AdapterPosition;
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract class GeolocatorAdapter {
  getCurrentPosition();

  double distanceBetween(double latitude, double longitude, double latitude2,
      double longitude2);

  placemarkFromPosition(AdapterPosition.Position searchPosition, {String? localeIdentifier});

  Stream<FPosition.Position>? userPosition;

  startStreamCurrentPosition();
}
@LazySingleton(as: GeolocatorAdapter)
class GeolocatorAdapterImpl implements GeolocatorAdapter {

  late StreamController<FPosition.Position> _fUserCurrentPositionStreamController;

  GeolocatorAdapterImpl(){
    _fUserCurrentPositionStreamController = StreamController<FPosition.Position>.broadcast();
    userPosition = _fUserCurrentPositionStreamController.stream;
  }

  @override
  Future<AdapterPosition.Position> getCurrentPosition() async {
    Geolocator.Position position = await GeolocatorPlatform.instance.getCurrentPosition()
        .timeout(Duration(seconds: 20));

    _fUserCurrentPositionStreamController.add(FPosition.Position.fromMap(position.toJson()));
    AdapterPosition.Position adapterPosition = AdapterPosition.Position.fromMap(
        position.toJson());
    return adapterPosition;
  }

  @override
   double distanceBetween(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude)  {
    return GeolocatorPlatform.instance.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  @override
  Future<List<AdapterPlacemark.Placemark>> placemarkFromPosition(
      AdapterPosition.Position searchPosition,
      {String? localeIdentifier}) async {
    Geolocator.Position position = Geolocator.Position.fromMap(
        searchPosition.toJson());
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,localeIdentifier:localeIdentifier);
    List<AdapterPlacemark.Placemark> adatperPlaceMarkers = [];
    placemarks.forEach((element) {
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
    GeolocatorPlatform.instance.getPositionStream(
      desiredAccuracy: Geolocator.LocationAccuracy.high,
      distanceFilter: _distanceFilter,
      forceAndroidLocationManager: true,
      timeInterval: 60000).listen((Geolocator.Position event) {
      _fUserCurrentPositionStreamController.add(FPosition.Position.fromMap(event.toJson()));
    });

  }

  int _distanceFilter = 5;

  @override
  Stream<FPosition.Position>? userPosition;

  dispose(){
    _fUserCurrentPositionStreamController.close();
  }
}