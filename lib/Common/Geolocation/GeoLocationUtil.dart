

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/Preference.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as Permit;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeoLocationUtil {
  ///GPS 가 사용 가능한지 알아보는 메소드
  ///만약 GPS off 면 on 요청 해줌 Flutter 권한 관련 오류로 요청 메세지를 던지기만 하고 타임 아웃으로 빠져 나옴
  Geolocator _geolocator = Geolocator();
  static final GeoLocationUtil _instance = GeoLocationUtil._internal();

  factory GeoLocationUtil() {
    return _instance;
  }

  GeoLocationUtil._internal();


  Future<bool> useGpsReq(BuildContext context) async {
      GlobalModel globalModel = Provider.of(context,listen: false);
      await globalModel.geoRequestMutex.acquire();

      Location location = new Location();
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          globalModel.geoRequestMutex.release();
          return false;
        }
      }
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          globalModel.geoRequestMutex.release();
          return false;
        }
      }
      globalModel.geoRequestMutex.release();
    return true;
  }

  Future<Position> getCurrentWithLastPosition() async{
    Location location = new Location();
    bool _serviceEnabled;
    _serviceEnabled = await location.serviceEnabled();
    Position resultPosition;
    if(!_serviceEnabled){
      resultPosition = await getLastKnowPonePosition();
    }else {
      var sharedPreferences = await SharedPreferences.getInstance();
      resultPosition = await _geolocator.getCurrentPosition();
      sharedPreferences.setDouble("currentlong", resultPosition.longitude);
      sharedPreferences.setDouble("currentlat", resultPosition.latitude);
    }

    return resultPosition;
  }

  Future<Position> getLastKnowPonePosition() async{
    var sharedPreferences = await SharedPreferences.getInstance();
    var currentlong = sharedPreferences.getDouble("currentlong");
    var currentlat = sharedPreferences.getDouble("currentlat");
    Position knowPosition ;
    if(currentlong != null && currentlat != null){
      knowPosition =Position(longitude:currentlong,latitude:currentlat);
    }else {
      knowPosition = Position(longitude: Preference.initPosition.longitude,latitude:Preference.initPosition.latitude);
    }
    return knowPosition;
  }

  Future<bool> permissionCheck() async {
    bool _serviceEnabled;
    Location location = new Location();
    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled) {
      return false;
    }else {
      return true;
    }
  }

  String replacePlacemarkToAddresStr(Placemark placemark) {
    String resultAddress = "";
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea.length != 0) {
      resultAddress += placemark.administrativeArea;
      if (placemark.subLocality != null && placemark.subLocality.length != 0) {
        resultAddress += (" " + placemark.subLocality);
      } else {
        resultAddress += (" " + placemark.locality);
      }

      if (placemark.thoroughfare != null &&
          placemark.thoroughfare.length != 0) {
        resultAddress += (" " + placemark.thoroughfare);
        if (placemark.subThoroughfare != null &&
            placemark.subThoroughfare.length != 0) {
          resultAddress += (" " + placemark.subThoroughfare);
        }
      }
    } else {
      resultAddress = "";
    }
    return resultAddress;
  }
}
