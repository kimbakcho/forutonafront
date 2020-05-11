import 'dart:core';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Preference {
  static String kGoogleApiKey = "AIzaSyAyyDPdP91f5RgxKjXbAPZr0lBVSyeZbGU";
  static LatLng initPosition = LatLng(37.550982, 126.990889);
  static String basicProfileImageUrl = "https://storage.googleapis.com/publicforutona/profileimage/basicprofileimage.png";
  
  //testDebug
//  static String baseBackEndUrl = "http://121.136.211.241:8443";
//  static Uri httpurlbase(String authority, String unencodedPath) {
//    return Uri.http(authority, unencodedPath);
//  }
//
//  static Uri httpurloption(String authority, String unencodedPath,
//      [Map<String, String> queryParameters]) {
//    return Uri.http(authority, unencodedPath, queryParameters);
//  }

//  // relese
   static String baseBackEndUrl = "https://forutona.thkomeet.com:8443/forutonabeta";
   static Uri httpurlbase(String authority, String unencodedPath) {
     return Uri.https("forutona.thkomeet.com:8443", "/forutonabeta/" + unencodedPath);
   }

   static Uri httpurloption(String authority, String unencodedPath,
       [Map<String, String> queryParameters]) {
     return Uri.https("forutona.thkomeet.com:8443", "/forutonabeta/" + unencodedPath, queryParameters);
   }
}
