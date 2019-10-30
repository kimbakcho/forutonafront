import 'dart:convert';
import 'dart:io';

import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

part 'UserInfoMain.g.dart';

@JsonSerializable()
class UserInfoMain {
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
  UserInfoMain();

  static Future<int> insertUserInfo(
    UserInfoMain item,
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
        //클레임 토큰 업데이트 시켜 줘야함. 아래 코드 작성 필요
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

  static Future<String> getCustomToken(UserInfoMain item) async {
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Auth/SnsLoginFireBase");
    var response = await http.post(posturl,
        body: jsonEncode(item.toJson()),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    return response.body;
  }

  factory UserInfoMain.fromJson(Map<String, dynamic> json) =>
      _$UserInfoMainFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoMainToJson(this);

  static Future<String> uploadWithGetProfileimage() async {
    var uploadurl = Preference.httpurlbase(
        Preference.baseBackEndUrl, '/api/v1/Auth/UploadProfileImage');
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);
        
    var request = new http.MultipartRequest("POST", uploadurl);
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('ProfileImage', image.path);
    request.files.add(multipartFile);
    StreamedResponse streamresponse = await request.send();
    Response response = await Response.fromStream(streamresponse);
    if (response.statusCode == 200) {
      var revlink = response.body;
      return revlink;
    } else {
      return "";
    }
  }
}
