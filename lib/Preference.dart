import 'dart:core';

class Preference {
  static String kGoogleApiKey = "AIzaSyAyyDPdP91f5RgxKjXbAPZr0lBVSyeZbGU";

  //testDebug
  static String baseBackEndUrl = "222.98.55.231:8443";
  static Uri httpurlbase(String authority, String unencodedPath) {
    return Uri.http(authority, unencodedPath);
  }

  static Uri httpurloption(String authority, String unencodedPath,
      [Map<String, String> queryParameters]) {
    return Uri.http(authority, unencodedPath, queryParameters);
  }

  // relese
  // static String baseBackEndUrl = "forutona.thkomeet.com:8443";
  // static Uri httpurlbase(String authority, String unencodedPath) {
  //   return Uri.https(authority, "/forutona/" + unencodedPath);
  // }

  // static Uri httpurloption(String authority, String unencodedPath,
  //     [Map<String, String> queryParameters]) {
  //   return Uri.https(authority, "/forutona/" + unencodedPath, queryParameters);
  // }
}
