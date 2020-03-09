import 'package:country_pickers/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/LoginPage/Component/APartCheckBox.dart';
import 'package:forutonafront/LoginPage/Component/SnsLoginDataLogic.dart';
import 'package:forutonafront/globals.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class A006SignIn3View extends StatefulWidget {
  A006SignIn3View({this.userinfomain, Key key}) : super(key: key);
  final UserInfoMain userinfomain;

  @override
  _A006SignIn3ViewState createState() {
    return _A006SignIn3ViewState(userinfomain: userinfomain);
  }
}

class _A006SignIn3ViewState extends State<A006SignIn3View> {
  _A006SignIn3ViewState({this.userinfomain});
  UserInfoMain userinfomain;
  ImageProvider<dynamic> userimage;
  int inityear;
  int initmonth;
  int initday;
  APartCheckBoxItem maleitem;
  APartCheckBoxItem femaleitem;
  TextEditingController nickController = TextEditingController();
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    userimage = AssetImage("assets/MainImage/emptyuser.png");
    if (userinfomain.snsservice == SnsLoginDataLogic.email) {
      inityear = DateTime.now().year;
      initmonth = 1;
      initday = 1;
      userinfomain.sex = 1;
      maleitem = APartCheckBoxItem(
          check: true,
          text: "남성",
          onchnage: (value) {
            if (value) {
              userinfomain.sex = 1;
              femaleitem.check = false;
            }
            setState(() {});
          });
      femaleitem = APartCheckBoxItem(
          check: false,
          text: "여성",
          onchnage: (value) {
            if (value) {
              userinfomain.sex = 2;
              maleitem.check = false;
            }
            setState(() {});
          });
      if (userinfomain.profilepicktureurl.length > 0) {
        userimage = NetworkImage(userinfomain.profilepicktureurl);
      }
      nickController.text = userinfomain.nickname;
      vaildcheck();
    } else if (userinfomain.snsservice == SnsLoginDataLogic.facebook) {
      userinfomain.isocode = "KR";
      inityear = DateTime.now().year;

      initmonth = 1;
      initday = 1;
      userinfomain.sex = 1;
      maleitem = APartCheckBoxItem(
          check: true,
          text: "남성",
          onchnage: (value) {
            if (value) {
              userinfomain.sex = 1;
              femaleitem.check = false;
            }
            setState(() {});
          });
      femaleitem = APartCheckBoxItem(
          check: false,
          text: "여성",
          onchnage: (value) {
            if (value) {
              userinfomain.sex = 2;
              maleitem.check = false;
            }
            setState(() {});
          });
      if (userinfomain.profilepicktureurl.length > 0) {
        userimage = NetworkImage(userinfomain.profilepicktureurl);
      }
      nickController.text = userinfomain.nickname;
      vaildcheck();
    } else if (userinfomain.snsservice == SnsLoginDataLogic.kakao) {
      userinfomain.isocode = "KR";
      inityear = DateTime.now().year;

      initmonth = 1;
      initday = 1;
      userinfomain.sex = 1;
      maleitem = APartCheckBoxItem(
          check: true,
          text: "남성",
          onchnage: (value) {
            if (value) {
              userinfomain.sex = 1;
              femaleitem.check = false;
            }
            setState(() {});
          });
      femaleitem = APartCheckBoxItem(
          check: false,
          text: "여성",
          onchnage: (value) {
            if (value) {
              userinfomain.sex = 2;
              maleitem.check = false;
            }
            setState(() {});
          });
      if (userinfomain.profilepicktureurl.length > 0) {
        userimage = NetworkImage(userinfomain.profilepicktureurl);
      }
      nickController.text = userinfomain.nickname;
      vaildcheck();
    } else if (userinfomain.snsservice == SnsLoginDataLogic.naver) {
      userinfomain.isocode = "KR";
      inityear = DateTime.now().year;
      initmonth = 1;
      initday = 1;
      userinfomain.sex = 1;
      maleitem = APartCheckBoxItem(
          check: true,
          text: "남성",
          onchnage: (value) {
            if (value) {
              userinfomain.sex = 1;
              femaleitem.check = false;
            }
            setState(() {});
          });
      femaleitem = APartCheckBoxItem(
          check: false,
          text: "여성",
          onchnage: (value) {
            if (value) {
              userinfomain.sex = 2;
              maleitem.check = false;
            }
            setState(() {});
          });
      if (userinfomain.profilepicktureurl.length > 0) {
        userimage = NetworkImage(userinfomain.profilepicktureurl);
      }
      nickController.text = userinfomain.nickname;
      vaildcheck();
    }
  }

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("(${country.isoCode})"),
          ],
        ),
      );
  bool isnext = false;

  vaildcheck() {
    if (userinfomain.nickname.length != 0 && userinfomain.agedate.length != 0) {
      isnext = true;
    } else {
      isnext = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF606060), Color(0xFF0E1014)]),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: AssetImage("assets/MainImage/map-846083_1920.png"))),
      child: LoadingOverlay(
        isLoading: isloading,
        progressIndicator: Loading(
            indicator: BallScaleIndicator(),
            size: 100.0,
            color: Theme.of(context).accentColor),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              isnext
                  ? Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 16),
                      child: Container(
                        height: 37.00,
                        width: 67.00,
                        decoration: BoxDecoration(
                            color: Color(0xFF454F63),
                            border: Border.all(
                              width: 2.00,
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(30.00)),
                        child: FlatButton(
                            child: Text(
                              "완료",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'Noto Sans CJK KR',
                                  fontSize: 16),
                            ),
                            onPressed: () async {
                              isloading = true;
                              setState(() {});
                              GlobalStateContainer.of(context).state.isnewuser =
                                  true;
                              int result = await UserInfoMain.insertUserInfo(
                                  userinfomain);
                              if (result > 0) {
                                GlobalStateContainer.of(context)
                                        .state
                                        .userInfoMain =
                                    await UserInfoMain.getUserInfoMain(
                                        await FirebaseAuth.instance
                                            .currentUser());
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/'));
                              }
                              isloading = false;
                              setState(() {});
                            }),
                      ))
                  : Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 16),
                      child: Container(
                        height: 37.00,
                        width: 67.00,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.00,
                              color: Color(0xffcccccc),
                            ),
                            borderRadius: BorderRadius.circular(30.00)),
                        child: FlatButton(
                          child: Text(
                            "완료",
                            style: TextStyle(
                                color: Color(0xff999999),
                                fontFamily: 'Noto Sans CJK KR',
                                fontSize: 16),
                          ),
                          onPressed: () async {},
                        ),
                      ))
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Container(
              child: Column(children: <Widget>[
            Container(
              child: Text("거의 다 왔습니다!",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color(0xffffffff),
                  )),
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              child: Text("간단한 프로필을 입력하고 입장합니다.",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontSize: 13,
                    color: Color(0xffffffff),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                      top: 41,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            color: Color(0xFFE4E7E8),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.00),
                                topRight: Radius.circular(16.00))),
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            SizedBox(
                              height: 53,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 31),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(16, 0, 8, 0),
                                    child: CountryPickerDropdown(
                                      initialValue: userinfomain.isocode,
                                      itemBuilder: _buildDropdownItem,
                                      onValuePicked: (Country country) {
                                        userinfomain.isocode = country.isoCode;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: TextField(
                                        onChanged: (value) {
                                          userinfomain.nickname = value;
                                          vaildcheck();
                                          setState(() {});
                                        },
                                        controller: nickController,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(16, 0, 16, 0),
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: "닉네임 입력",
                                          hintStyle: TextStyle(
                                            fontFamily: "Noto Sans CJK KR",
                                            fontSize: 15,
                                            color: Color(0xff78849e)
                                                .withOpacity(0.56),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0))),
                                        )),
                                  ))
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(32, 0, 68, 0),
                                  child: Text("성별",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontSize: 15,
                                        color: Color(0xff454f63),
                                      )),
                                ),
                                APartCheckBox(
                                  item: maleitem,
                                ),
                                SizedBox(width: 13),
                                APartCheckBox(
                                  item: femaleitem,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 31,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(32, 0, 16, 0),
                                  child: Text("생년월일",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontSize: 15,
                                        color: Color(0xff454f63),
                                      )),
                                ),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 32),
                                  child: FlatButton(
                                      onPressed: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(
                                                DateTime.now().year - 100,
                                                1,
                                                1),
                                            maxTime: DateTime(
                                                DateTime.now().year - 14,
                                                12,
                                                31),
                                            theme: DatePickerTheme(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                itemStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                doneStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            onChanged: (date) {},
                                            onConfirm: (date) {
                                          setState(() {
                                            userinfomain.agedate =
                                                DateFormat("yyyy-MM-dd")
                                                    .format(date);
                                            vaildcheck();
                                          });
                                        },
                                            currentTime: DateTime(
                                                inityear, initmonth, initday),
                                            locale: LocaleType.ko);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: userinfomain
                                                          .agedate.length ==
                                                      0
                                                  ? Text("연도/월/일")
                                                  : Text(
                                                      "${userinfomain.agedate}")),
                                          Icon(Icons.arrow_drop_down)
                                        ],
                                      )),
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 4.00),
                                        color:
                                            Color(0xff455b63).withOpacity(0.08),
                                        blurRadius: 16,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(12.00),
                                  ),
                                ))
                              ],
                            )
                          ],
                        ),
                      )),
                  Positioned(
                      top: 0,
                      width: 68,
                      height: 68,
                      left: MediaQuery.of(context).size.width / 2 - 34,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0xff78849E), width: 1),
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: userimage),
                              shape: BoxShape.circle),
                          child: FlatButton(
                              shape: CircleBorder(),
                              child: Container(),
                              onPressed: () async {
                                String profileimagelink = await UserInfoMain
                                    .uploadWithGetProfileimage();
                                userinfomain.profilepicktureurl =
                                    profileimagelink;
                                userimage = NetworkImage(
                                    userinfomain.profilepicktureurl);
                                setState(() {});
                              })))
                ],
              ),
            )
          ])),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 10,
            child: LinearProgressIndicator(
              value: 1,
              backgroundColor: Color(0xffCCCCCC),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF39F999)),
            ),
          ),
        ),
      ),
    );
  }
}
