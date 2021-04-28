import 'package:google_maps_flutter/google_maps_flutter.dart';
///MapGeoSearchPage 의 Navigator는 해당 Dto 메세지를 통해 Caller와 메세지를 주고 받는다.
class MapSearchGeoDto{
  String? address;
  LatLng? latLng;
  String? descriptionAddress;
}