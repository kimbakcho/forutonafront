import 'package:geolocator/geolocator.dart';

class GeolocationRepository {
  Future<Position> getCurrentPhoneLocation() async {
    if (await isCanGPS()) {
      var position = await Geolocator().getCurrentPosition();
      if (position == null) {
        position = await Geolocator().getCurrentPosition();
      }
      return position;
    } else {
      return null;
    }
  }

  Future<String> getCurrentPhoneAddress() async {
    var position = await getCurrentPhoneLocation();
    String resultAddress = "";
    if (position != null) {
      var placeMarkList = await Geolocator()
          .placemarkFromPosition(position, localeIdentifier: "ko");
      if (placeMarkList.length > 0) {
        resultAddress = "";

        if (placeMarkList[0].administrativeArea != null &&
            placeMarkList[0].administrativeArea.length != 0) {
          resultAddress += placeMarkList[0].administrativeArea;
          if (placeMarkList[0].subLocality != null &&
              placeMarkList[0].subLocality.length != 0) {
            resultAddress += (" " + placeMarkList[0].subLocality);
            if (placeMarkList[0].thoroughfare != null &&
                placeMarkList[0].thoroughfare.length != 0) {
              resultAddress += (" " + placeMarkList[0].thoroughfare);
              if (placeMarkList[0].subThoroughfare != null &&
                  placeMarkList[0].subThoroughfare.length != 0) {
                resultAddress += (" " + placeMarkList[0].subThoroughfare);
              }
            }
          }
        } else {
          resultAddress = "";
        }
      } else {
        resultAddress = "";
      }
    }
    if(resultAddress.length == 0){
      return "주 소 없 음";
    }else {
      return resultAddress;
    }

  }

  Future<bool> isCanGPS() async {
    Geolocator geoLocator = Geolocator()..forceAndroidLocationManager = true;
    GeolocationStatus geolocationStatus =
        await geoLocator.checkGeolocationPermissionStatus();
    if (geolocationStatus.value == 2 || geolocationStatus.value == 3) {
      return true;
    } else {
      return false;
    }
  }
}
