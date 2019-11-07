import 'dart:convert';
import 'dart:io';

import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/globals.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

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
  int agelimitagree = 0;
  String password = "";
  String snsservice = "";
  String snstoken = "";
  String phoneauthcheckcode = "";
  String phonenumber = "";
  String isocode = "";
  UserInfoMain();

  UserInfoMain.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    profilepicktureurl = json['profilepicktureurl'];
    sex = json['sex'];
    agedate = json['agedate'];
    email = json['email'];
    forutonaagree = json['forutonaagree'];
    privateagree = json['privateagree'];
    positionagree = json['positionagree'];
    martketingagree = json['martketingagree'];
    agelimitagree = json['agelimitagree'];
    password = json['password'];
    snsservice = json['snsservice'];
    snstoken = json['snstoken'];
    phoneauthcheckcode = json['phoneauthcheckcode'];
    phonenumber = json['phonenumber'];
    isocode = json['isocode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['profilepicktureurl'] = this.profilepicktureurl;
    data['sex'] = this.sex;
    data['agedate'] = this.agedate;
    data['email'] = this.email;
    data['forutonaagree'] = this.forutonaagree;
    data['privateagree'] = this.privateagree;
    data['positionagree'] = this.positionagree;
    data['martketingagree'] = this.martketingagree;
    data['agelimitagree'] = this.agelimitagree;
    data['password'] = this.password;
    data['snsservice'] = this.snsservice;
    data['snstoken'] = this.snstoken;
    data['phoneauthcheckcode'] = this.phoneauthcheckcode;
    data['phonenumber'] = this.phonenumber;
    data['isocode'] = this.isocode;
    return data;
  }

  static Future<int> insertUserInfo(
    UserInfoMain item,
  ) async {
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Auth/InsertUserInfo");
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (item.password != null && item.password.length >= 6) {
      IdTokenResult token;
      try {
        AuthResult reslut = await _auth.createUserWithEmailAndPassword(
            email: item.email, password: item.password);
        item.uid = reslut.user.uid;
        token = await reslut.user.getIdToken();
      } catch (ex) {
        AuthResult reslut = await _auth.signInWithEmailAndPassword(
            email: item.email, password: item.password);
        token = await reslut.user.getIdToken();
      }

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

  static Future<String> uploadWithGetProfileimage() async {
    var uploadurl = Preference.httpurlbase(
        Preference.baseBackEndUrl, '/api/v1/Auth/UploadProfileImage');
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 150, maxWidth: 150);

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

  static void requestAuthPhoneNumber(
      String uuid, String phonenumber, String isocode) async {
    var requesturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Auth/requestAuthPhoneNumber");
    Response response = await http.post(requesturl,
        body: jsonEncode({
          "uuid": uuid,
          "phonenumber": phonenumber,
          "authnumber": '',
          'isocode': isocode
        }),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
  }

  static Future<String> requestAuthVerificationPhoneNumber(
      String uuid, String phonenumber, String authnumber) async {
    var requesturl = Preference.httpurlbase(Preference.baseBackEndUrl,
        "/api/v1/Auth/requestAuthVerificationPhoneNumber");
    Response response = await http.post(requesturl,
        body: jsonEncode({
          "uuid": uuid,
          "phonenumber": phonenumber,
          "authnumber": authnumber
        }),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    return response.body;
  }

  static Future<UserInfoMain> getUserInfoMain(FirebaseUser firebaseUser) async {
    IdTokenResult token = await firebaseUser.getIdToken();

    var geturl = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Auth/GetUserInfoMain", {"uid": firebaseUser.uid});
    Response response = await http.get(geturl, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token.token,
    });
    UserInfoMain userinfomain =
        UserInfoMain.fromJson(jsonDecode(response.body));
    return userinfomain;
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  static String validatePassword(String value) {
    if (value.length < 8) {
      return "short password";
    }
    return null;
  }

  static Future<UserInfoMain> getUsePasswordFindPhoneInfoByemail(
      String email) async {
    var params = {"email": email};
    var requesturl = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Auth/getUsePasswordFindPhoneInfoByemail", params);
    var response = await http.get(requesturl);
    UserInfoMain userinfo = UserInfoMain.fromJson(jsonDecode(response.body));
    return userinfo;
  }

  static Future<int> passwrodChangefromphone(UserInfoMain userinfo) async {
    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Auth/passwrodChangefromphone");
    var response = await http.post(url,
        body: jsonEncode(userinfo.toJson()),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    return int.tryParse(response.body);
  }
}
