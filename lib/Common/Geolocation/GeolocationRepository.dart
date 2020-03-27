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
        resultAddress = placeMarkList[0].administrativeArea +
            " " +
            placeMarkList[0].thoroughfare +
            " " +
            placeMarkList[0].subThoroughfare +
            placeMarkList[0].name;
        return resultAddress;
      }
    }
    return "주 소 없 음";
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
