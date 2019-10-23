import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';

class LoginPageView extends StatefulWidget {
  LoginPageView({Key key}) : super(key: key);

  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            child: Text("<"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).size.height * 0.1, 20, 10),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'ID(Email)',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
            Container(
              height: 10,
            ),
            TextField(
              controller: passController,
              decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
            Container(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: Text(
                  "Log-in",
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {},
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              alignment: Alignment(1, 0),
              child: GestureDetector(
                child: Text(
                  "아직 회원이 아니신가요?",
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.blue),
                ),
                onTap: () {},
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              alignment: Alignment(1, 0),
              child: GestureDetector(
                child: Text("혹시, 패스워드를 잃어버렸나요?",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue)),
                onTap: () {},
              ),
            ),
            Container(
              height: 30,
            ),
            Divider(
              thickness: 3,
            ),
            Container(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: Text(
                  "네이버 로그인",
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () async {
                  NaverLoginResult res1 = await FlutterNaverLogin.logIn();
                  print(res1.account.id);
                  print(res1.account.age);
                  NaverAccessToken res2 =
                      await FlutterNaverLogin.currentAccessToken;
                  print(res2.accessToken);
                  print(res2.expiresAt);
                },
              ),
            ),
            Container(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: Text("KaKao 로그인", style: TextStyle(fontSize: 25)),
                onPressed: () async {
                  FlutterKakaoLogin kakaoSignIn = new FlutterKakaoLogin();
                  if (await kakaoSignIn.isLoggedIn) {
                    print("로그인 되어있음");
                  } else {
                    final KakaoLoginResult result = await kakaoSignIn.logIn();
                    switch (result.status) {
                      case KakaoLoginStatus.loggedIn:
                        print(result.account.userID);
                        break;
                      case KakaoLoginStatus.loggedOut:
                        // TODO: Handle this case.
                        break;
                      case KakaoLoginStatus.error:
                        // TODO: Handle this case.
                        break;
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
