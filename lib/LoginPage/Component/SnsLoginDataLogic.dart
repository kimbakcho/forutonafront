import 'dart:convert';
import 'dart:io';

import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:forutonafront/Auth/UserInfo.dart' as forutona;
import 'package:http/http.dart' as http;

class SnsLoginDataLogic {
  static String naver = "Naver";
  static String kakao = "Kakao";
  static String facebook = "Facebook";
  static String email = "Facebook";
  static Future<bool> snsLogins(
      String loginpage, forutona.UserInfo userInfo) async {
    if (loginpage == SnsLoginDataLogic.naver) {
      NaverLoginResult res1 = await FlutterNaverLogin.logIn();
      var res2 = await FlutterNaverLogin.currentAccessToken;
      if (res2.accessToken != null) {
        userInfo.snsservice = SnsLoginDataLogic.naver;
        userInfo.snstoken = res2.accessToken;
        userInfo.uid = SnsLoginDataLogic.naver + res1.account.id;
        userInfo.email = res1.account.email;
        userInfo.profilepicktureurl = res1.account.profileImage;
        if (res1.account.gender == 'F') {
          userInfo.sex = 2;
        } else if (res1.account.gender == 'M') {
          userInfo.sex = 1;
        } else {
          userInfo.sex = 0;
        }
        List<String> ages = res1.account.age.split("-");
        int tempage = int.parse(ages[0]);
        int year = DateTime.now().year - tempage;
        List<String> birthday = res1.account.birthday.split("-");
        DateTime agedate =
            DateTime.utc(year, int.parse(birthday[0]), int.parse(birthday[1]));
        userInfo.agedate = DateFormat("yyyy-MM-dd").format(agedate);
        userInfo.nickname = res1.account.nickname;
        return true;
      } else {
        return false;
      }
    } else if (loginpage == SnsLoginDataLogic.kakao) {
      FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
      KakaoAccessToken accessToken;
      KakaoLoginResult result;
      if (await kakaoSignIn.isLoggedIn) {
        accessToken = await kakaoSignIn.currentAccessToken;
      } else {
        result = await kakaoSignIn.logIn();
        result = await kakaoSignIn.getUserMe();

        switch (result.status) {
          case KakaoLoginStatus.loggedIn:
            accessToken = await kakaoSignIn.currentAccessToken;
            break;
          case KakaoLoginStatus.loggedOut:
            return false;
            break;
          case KakaoLoginStatus.error:
            return false;
            break;
        }
      }
      var url = Preference.httpurlbase(
          Preference.baseBackEndUrl, "/api/v1/Auth/KakaoUserInfo");
      Response response = await http.post(url, headers: {
        HttpHeaders.authorizationHeader: "Bearer " + accessToken.token,
        HttpHeaders.contentTypeHeader: "application/json"
      });
      forutona.UserInfo userinfo =
          forutona.UserInfo.fromJson(jsonDecode(response.body));
      userinfo.snsservice = 'kakao';

      return false;
    } else {
      return false;
    }
  }
}
