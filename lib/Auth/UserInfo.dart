import 'dart:convert';
import 'dart:io';

import 'package:forutonafront/Preference.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

part 'UserInfo.g.dart';

@JsonSerializable()
class UserInfo {
  String uid;
  String nickname = "";
  String profilepicktureurl = "";
  int sex = 1;
  String agedate = "";
  String email = "";
  int forutonaagree = 0;
  int privateagree = 0;
  int positionagree = 0;
  int martketingagree = 0;
  String password = "";
  String snsservice = "";
  String snstoken = "";
  UserInfo();

  static Future<int> insertUserInfo(
    UserInfo item,
  ) async {
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Auth/InsertUserInfo");
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (item.password != null && item.password.length >= 6) {
      AuthResult reslut = await _auth.createUserWithEmailAndPassword(
          email: item.email, password: item.password);
      item.uid = reslut.user.uid;
      IdTokenResult token = await reslut.user.getIdToken();

      var response =
          await http.post(posturl, body: jsonEncode(item.toJson()), headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token.token,
        HttpHeaders.contentTypeHeader: "application/json"
      });
      return int.tryParse(response.body);
    } else {
      var posturl = Preference.httpurlbase(
          Preference.baseBackEndUrl, "/api/v1/Auth/SnsLoginFireBase");
      var response = await http.post(posturl,
          body: jsonEncode(item.toJson()),
          headers: {HttpHeaders.contentTypeHeader: "application/json"});
      if (response.body.length == 0) {
        return 0;
      } else {
        await _auth.signInWithCustomToken(token: response.body);
        return 1;
      }
    }
  }

  static Future<String> getCustomToken(UserInfo item) async {
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Auth/SnsLoginFireBase");
    var response = await http.post(posturl,
        body: jsonEncode(item.toJson()),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    return response.body;
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
