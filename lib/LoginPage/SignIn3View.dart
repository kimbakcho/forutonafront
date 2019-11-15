import 'package:date_util/date_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';

import 'package:forutonafront/LoginPage/Component/SnsLoginDataLogic.dart';
import 'package:forutonafront/globals.dart';
import 'package:intl/intl.dart';

class SignIn3View extends StatefulWidget {
  SignIn3View({Key key, this.userinfo, this.loginpage}) : super(key: key);
  final UserInfoMain userinfo;
  final String loginpage;
  @override
  _SignIn3ViewState createState() {
    return _SignIn3ViewState(userinfo: userinfo, loginpage: loginpage);
  }
}

class _SignIn3ViewState extends State<SignIn3View> {
  UserInfoMain userinfo;
  String loginpage;
  var _signIn3ViewscaffoldKey = new GlobalKey<ScaffoldState>();
  _SignIn3ViewState({
    this.loginpage,
    this.userinfo,
  });

  TextEditingController nickNameController = TextEditingController();

  List<int> yearslist = List<int>();
  List<int> monthlist = List<int>();
  List<int> daylist = List<int>();
  var dateUtility = new DateUtil();
  List<bool> sexarray = [true, false];
  int inityear;
  int initmonth;
  int initday;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      yearslist.add(DateTime.now().year - i);
    }
    for (var i = 1; i <= 12; i++) {
      monthlist.add(i);
    }
    daylist = _makedaylist(DateTime.now().year, 1);
    if (loginpage == SnsLoginDataLogic.email) {
      inityear = DateTime.now().year;
      initmonth = 1;
      initday = 1;
    } else if (loginpage == SnsLoginDataLogic.naver) {
      List<String> dateitem = userinfo.agedate.split("-");
      inityear = int.tryParse(dateitem[0]);
      initmonth = int.tryParse(dateitem[1]);
      initday = int.tryParse(dateitem[2]);
      nickNameController.text = userinfo.nickname;
      if (userinfo.sex == 0) {
        sexarray = [true, false];
      } else {
        sexarray = [false, true];
      }
    } else if (loginpage == SnsLoginDataLogic.kakao) {
      inityear = DateTime.now().year;
      initmonth = 1;
      initday = 1;
      nickNameController.text = userinfo.nickname;
      if (userinfo.sex == 0) {
        sexarray = [true, false];
      } else {
        sexarray = [false, true];
      }
    } else if (loginpage == SnsLoginDataLogic.facebook) {
      nickNameController.text = userinfo.nickname;
      inityear = DateTime.now().year;
      initmonth = 1;
      initday = 1;
    }
    userinfo.agedate =
        DateFormat("yyyy-MM-dd").format(DateTime(inityear, initmonth, initday));
  }

  List<int> _makedaylist(yeardownvalue, monthdownvalue) {
    List<int> daylist = List<int>();
    for (var i = 1;
        i <= dateUtility.daysInMonth(monthdownvalue, yeardownvalue);
        i++) {
      daylist.add(i);
    }
    return daylist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _signIn3ViewscaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("<"),
              onPressed: () {
                userinfo.nickname = "";
                userinfo.agedate = "";
                userinfo.sex = 1;
                Navigator.pop(context);
              },
            ),
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                child: Text('완료'),
                onPressed: () async {
                  if (userinfo.nickname.trim().length == 0) {
                    final snackBar = SnackBar(
                      content: Text("닉네임이 없습니다."),
                      duration: Duration(milliseconds: 1000),
                    );
                    _signIn3ViewscaffoldKey.currentState.showSnackBar(snackBar);
                    return;
                  }
                  GolobalStateContainer.of(context).state.isnewuser = true;
                  int result = await UserInfoMain.insertUserInfo(userinfo);
                  GolobalStateContainer.of(context).state.userInfoMain =
                      await UserInfoMain.getUserInfoMain(
                          await FirebaseAuth.instance.currentUser());

                  if (result == 0) {
                    final snackBar = SnackBar(
                      content: Text("전산에 오류가 생겼습니다."),
                      duration: Duration(milliseconds: 1000),
                    );
                    _signIn3ViewscaffoldKey.currentState.showSnackBar(snackBar);
                    return;
                  } else if (result == 1) {
                    final snackBar = SnackBar(
                      content: Text("축하 힙니다."),
                      duration: Duration(milliseconds: 1000),
                    );
                    _signIn3ViewscaffoldKey.currentState.showSnackBar(snackBar);
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  }
                },
              ),
            )
          ],
        ),
        body: new Builder(builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 20),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () async {
                          String profileimagelink =
                              await UserInfoMain.uploadWithGetProfileimage();
                          setState(() {
                            userinfo.profilepicktureurl = profileimagelink;
                          });
                        },
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: new BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage(userinfo.profilepicktureurl),
                                  fit: BoxFit.cover),
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.circle),
                          child: new Center(
                              child: new Icon(Icons.add_photo_alternate,
                                  size: MediaQuery.of(context).size.height *
                                      0.07)),
                        ))
                  ],
                ),
                Container(height: 30),
                TextFormField(
                  controller: nickNameController,
                  decoration: InputDecoration(
                      hintText: 'Nick name',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                  onChanged: (String value) {
                    userinfo.nickname = value;
                  },
                ),
                Container(height: 20),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      alignment: Alignment(0, 0),
                      child: Text("성별"),
                    ),
                    ToggleButtons(
                      selectedColor: Colors.white,
                      fillColor: Colors.blue,
                      selectedBorderColor: Colors.cyan,
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Center(
                            child: Text("남"),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Center(
                            child: Text("여"),
                          ),
                        ),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          if (index == 0) {
                            sexarray[0] = true;
                            sexarray[1] = false;
                            userinfo.sex = 0;
                          } else if (index == 1) {
                            sexarray[0] = false;
                            sexarray[1] = true;
                            userinfo.sex = 1;
                          }
                        });
                      },
                      isSelected: sexarray,
                    )
                  ],
                ),
                Container(height: 20),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      alignment: Alignment(0, 0),
                      child: Text("생일"),
                    ),
                    // Container(
                    //   width: 100,
                    //   child: DropDownPicker(
                    //     items: yearitem,
                    //   ),
                    // ),
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime:
                                  DateTime(DateTime.now().year - 100, 1, 1),
                              maxTime: DateTime(DateTime.now().year, 12, 31),
                              theme: DatePickerTheme(
                                  backgroundColor: Colors.blue,
                                  itemStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  doneStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16)), onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            setState(() {
                              userinfo.agedate =
                                  DateFormat("yyyy-MM-dd").format(date);
                            });
                          },
                              currentTime:
                                  DateTime(inityear, initmonth, initday),
                              locale: LocaleType.ko);
                        },
                        child: Text(userinfo.agedate),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }));
  }
}
