import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/LoginPage/PassWordFindView.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'Component/SnsLoginDataLogic.dart';
import 'SignIn1View.dart';

class LoginPageView extends StatefulWidget {
  LoginPageView({Key key}) : super(key: key);

  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _loginPageViewStateScaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  // • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
  ///   • `ERROR_WRONG_PASSWORD` - If the [password] is wrong.
  ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address, or if the user has been deleted.
  ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
  ///   • `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
  ///   • `ERROR_OPERATION_NOT_ALLOWED`
  String changeLoginErrorMesage(String text) {
    switch (text) {
      case "ERROR_INVALID_EMAIL":
        return "Email형식이 틀렸습니다.";
      case "ERROR_WRONG_PASSWORD":
        return "패스워드가틀렸습니다.";
      case "ERROR_USER_NOT_FOUND":
        return "사용자를 찾을수 업습니다.";
      case "ERROR_USER_DISABLED":
        return "사용할수 없는 유져 입니다.";
      case "ERROR_TOO_MANY_REQUESTS":
        return "너무많은요청을했습니다.";
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "허용할수 없는 요청입니다..";
      default:
        return "알수 없음";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _loginPageViewStateScaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leading: Container(
            child: FlatButton(
              child: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: new Builder(builder: (context) {
          return Container(
            child: ListView(
              children: <Widget>[
                Container(
                  child: Image(
                    height: MediaQuery.of(context).size.height * 0.20,
                    image: AssetImage("assets/Brand/SplashImage.png"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: '아이디(이메일)',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                      obscureText: true,
                      controller: passController,
                      decoration: InputDecoration(hintText: '패스워드')),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.065,
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      "로그인",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onPressed: () async {
                      try {
                        await _auth.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text);
                      } catch (value) {
                        PlatformException excode = value as PlatformException;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    )
                                  ],
                                  content: Container(
                                      child: Text(changeLoginErrorMesage(
                                          excode.code))));
                            });
                        return;
                      }
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  alignment: Alignment(1, 0),
                  child: GestureDetector(
                    child: Text(
                      "아직 회원이 아니신가요?",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFF6c6fab)),
                    ),
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        var userinfo = new UserInfoMain();
                        return SignInView(
                            userinfo: userinfo, loginpage: "Email");
                      }));
                    },
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  alignment: Alignment(1, 0),
                  child: GestureDetector(
                    child: Text("혹시, 패스워드를 잃어버렸나요?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xFF6c6fab))),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PassWordFindView();
                      }));
                    },
                  ),
                ),
                Divider(
                  indent: 30,
                  endIndent: 30,
                  color: Colors.black,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.065,
                    margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: RaisedButton(
                        color: Color(0xFF36bc3a),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Text(
                          "네이버 로그인",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        onPressed: () async {
                          var userinfo = new UserInfoMain();
                          bool loginresult = await SnsLoginDataLogic.snsLogins(
                              SnsLoginDataLogic.naver, userinfo);
                          if (!loginresult) {
                            return;
                          }
                          var queryParameters = {
                            'Uid': userinfo.uid,
                          };
                          var uri = Preference.httpurloption(
                              Preference.baseBackEndUrl,
                              '/api/v1/Auth/GetUid',
                              queryParameters);
                          var response = await http.get(uri);
                          String getuid = response.body;

                          if (userinfo.uid == getuid) {
                            String customtoken =
                                await UserInfoMain.getCustomToken(userinfo);
                            await _auth.signInWithCustomToken(
                                token: customtoken);
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignInView(
                                loginpage: SnsLoginDataLogic.naver,
                                userinfo: userinfo,
                              );
                            }));
                          }
                        })),
                Container(
                  height: MediaQuery.of(context).size.height * 0.065,
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: RaisedButton(
                    color: Color(0xFF3426ff),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text("FaceBook 로그인",
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    onPressed: () async {
                      var userinfo = new UserInfoMain();
                      bool loginresult = await SnsLoginDataLogic.snsLogins(
                          SnsLoginDataLogic.facebook, userinfo);
                      if (!loginresult) {
                        return;
                      }
                      var queryParameters = {
                        'Uid': userinfo.uid,
                      };
                      var uri = Preference.httpurloption(
                          Preference.baseBackEndUrl,
                          '/api/v1/Auth/GetUid',
                          queryParameters);
                      var response = await http.get(uri);
                      String getuid = response.body;
                      if (userinfo.uid == getuid) {
                        String customtoken =
                            await UserInfoMain.getCustomToken(userinfo);
                        await _auth.signInWithCustomToken(token: customtoken);
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignInView(
                            userinfo: userinfo,
                            loginpage: SnsLoginDataLogic.facebook,
                          );
                        }));
                      }
                    },
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.065,
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: RaisedButton(
                    color: Color(0xFFeccd01),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text("KaKao 로그인",
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    onPressed: () async {
                      var userinfo = new UserInfoMain();
                      bool loginresult = await SnsLoginDataLogic.snsLogins(
                          SnsLoginDataLogic.kakao, userinfo);
                      if (!loginresult) {
                        return;
                      }
                      var queryParameters = {
                        'Uid': userinfo.uid,
                      };
                      var uri = Preference.httpurloption(
                          Preference.baseBackEndUrl,
                          '/api/v1/Auth/GetUid',
                          queryParameters);
                      var response = await http.get(uri);
                      String getuid = response.body;

                      if (userinfo.uid == getuid) {
                        String customtoken =
                            await UserInfoMain.getCustomToken(userinfo);
                        await _auth.signInWithCustomToken(token: customtoken);

                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignInView(
                            userinfo: userinfo,
                            loginpage: SnsLoginDataLogic.kakao,
                          );
                        }));
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
