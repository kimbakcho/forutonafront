import 'dart:core';

import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Preference {
   String kGoogleApiKey = "AIzaSyAyyDPdP91f5RgxKjXbAPZr0lBVSyeZbGU";
   Position initPosition = Position(latitude: 37.508797,longitude: 126.890605);
   String initAddress = "신도림";
   String basicProfileImageUrl = "https://storage.googleapis.com/publicforutona/profileimage/basicprofileimage.png";
   String kaKaoNativeApiKey = "2e77dd42e5b6e1e79b8a0ec21e242e05";
   String officialSite="http://neoforutona.cafe24.com/official-channel/";

  //testDebug
   String baseBackEndUrl = "http://121.136.211.241:8443";
//  // relese
//    String baseBackEndUrl = "https://forutona.thkomeet.com:8443/forutonabeta";

}
