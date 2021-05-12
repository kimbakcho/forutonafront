import 'dart:core';

import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';



class Preference {
   static final String kGoogleApiKey = "AIzaSyAyyDPdP91f5RgxKjXbAPZr0lBVSyeZbGU";
   static final Position initPosition = Position(latitude: 37.508797,longitude: 126.890605);
   static final String initAddress = "신도림";
   static final String kaKaoNativeApiKey = "2015f6758833a937d29f1189220831f7";
   static final String officialSite="http://neoforutona.cafe24.com/official-channel/";

  //testDebug
   static final String baseBackEndUrl = "http://218.148.4.207:8443";

//  // relese
//    static final String baseBackEndUrl = "https://forutona.thkomeet.com:8443/forutonabeta";

   //realtestRelese
  // static final String baseBackEndUrl = "https://forutona.thkomeet.com:8443/forutonatest";

}
