import 'dart:core';

import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:injectable/injectable.dart';


class Preference {
   static final String kGoogleApiKey = "AIzaSyAyyDPdP91f5RgxKjXbAPZr0lBVSyeZbGU";
   static final Position initPosition = Position(latitude: 37.508797,longitude: 126.890605);
   static final String initAddress = "신도림";
   static final String basicProfileImageUrl = "https://storage.googleapis.com/publicforutona/profileimage/basicprofileimage.png";
   static final String kaKaoNativeApiKey = "2e77dd42e5b6e1e79b8a0ec21e242e05";
   static final String officialSite="http://neoforutona.cafe24.com/official-channel/";

  //testDebug
   static final String baseBackEndUrl = "http://175.195.195.27:8443";
//  // relese
//    String baseBackEndUrl = "https://forutona.thkomeet.com:8443/forutonabeta";

   //realtestRelese
//   String baseBackEndUrl = "https://forutona.thkomeet.com:8443/forutonatest";

}
