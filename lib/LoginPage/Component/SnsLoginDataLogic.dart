import 'dart:convert';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:intl/intl.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class SnsLoginDataLogic {
  static String naver = "Naver";
  static String kakao = "Kakao";
  static String facebook = "Facebook";
  static String email = "Email";
  static Future<bool> snsLogins(String loginpage, UserInfoMain userInfo) async {
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
          userInfo.sex = 1;
        } else if (res1.account.gender == 'M') {
          userInfo.sex = 0;
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
      KakaoLoginResult result;
      if (await kakaoSignIn.isLoggedIn) {
        result = await kakaoSignIn.getUserMe();
        userInfo.uid = SnsLoginDataLogic.kakao + result.account.userID;
        print(userInfo.uid);
        userInfo.email = result.account.userEmail;
        userInfo.profilepicktureurl = result.account.userProfileImagePath;
        userInfo.nickname = result.account.userNickname;
        userInfo.sex = 0;
        userInfo.snsservice = SnsLoginDataLogic.kakao;
        KakaoAccessToken token = await kakaoSignIn.currentAccessToken;

        userInfo.snstoken = token.token;
        print(userInfo.snstoken);
        return true;
      } else {
        result = await kakaoSignIn.logIn();
        switch (result.status) {
          case KakaoLoginStatus.loggedIn:
            result = await kakaoSignIn.getUserMe();
            userInfo.uid = SnsLoginDataLogic.kakao + result.account.userID;
            userInfo.email = result.account.userEmail;
            userInfo.profilepicktureurl = result.account.userProfileImagePath;
            userInfo.nickname = result.account.userNickname;
            userInfo.sex = 0;
            userInfo.snsservice = SnsLoginDataLogic.kakao;
            KakaoAccessToken token = await kakaoSignIn.currentAccessToken;
            userInfo.snstoken = token.token;
            return true;
            break;
          case KakaoLoginStatus.loggedOut:
            return false;
            break;
          case KakaoLoginStatus.error:
            print(result.errorMessage);
            return false;
            break;
        }
      }
      return false;
    } else if (loginpage == SnsLoginDataLogic.facebook) {
      final facebookLogin = FacebookLogin();

      if (await facebookLogin.isLoggedIn) {
        FacebookAccessToken token = await facebookLogin.currentAccessToken;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${token.token}');
        final profile = jsonDecode(graphResponse.body);
        userInfo.uid = SnsLoginDataLogic.facebook + profile["id"];
        userInfo.email = profile["email"];
        userInfo.nickname = profile["name"];
        userInfo.profilepicktureurl = profile["picture"]["data"]["url"];
        userInfo.snsservice = SnsLoginDataLogic.facebook;
        userInfo.snstoken = token.token;
        return true;
      } else {
        final result = await facebookLogin.logIn(['email']);
        switch (result.status) {
          case FacebookLoginStatus.loggedIn:
            //추후에 App FaceBook 에 인증후에 허가권 얻은후 'user_gender','user_age_range','user_birthday' 정보 얻기
            final graphResponse = await http.get(
                'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${result.accessToken.token}');
            final profile = jsonDecode(graphResponse.body);
            userInfo.uid = SnsLoginDataLogic.facebook + profile["id"];
            userInfo.email = profile["email"];
            userInfo.nickname = profile["name"];
            userInfo.profilepicktureurl = profile["picture"]["data"]["url"];
            userInfo.snsservice = SnsLoginDataLogic.facebook;
            userInfo.snstoken = result.accessToken.token;
            return true;
            break;
          case FacebookLoginStatus.cancelledByUser:
            return false;
            break;
          case FacebookLoginStatus.error:
            return false;
            break;
        }
      }
    } else {
      return false;
    }
    return false;
  }
}
