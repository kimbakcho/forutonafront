import 'dart:convert';
import 'dart:io';

import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

part 'UserInfo.g.dart';

@JsonSerializable()
class UserInfo {
  String uid;
  String nickname = "";
  String profilepicktureurl = "12315";
  int sex = 1;
  String agedate = "";
  String email = "";
  int forutonaagree = 0;
  int privateagree = 0;
  int positionagree = 0;
  int martketingagree = 0;
  String password = "";
  UserInfo();

  static Future<String> insertUserInfo(UserInfo item) async {
    var posturl =
        Uri.http(Preference.baseBackEndUrl, "/api/v1/Auth/UpdateUser");
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (item.password != null) {
      AuthResult reslut = await _auth.signInWithEmailAndPassword(
          email: item.email, password: item.password);
      item.uid = reslut.user.uid;
      IdTokenResult token = await reslut.user.getIdToken();

      var response =
          await http.post(posturl, body: jsonEncode(item.toJson()), headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token.token,
        HttpHeaders.contentTypeHeader: "application/json"
      });
      print(response.body);
      return response.body;
    }
    return "";
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
