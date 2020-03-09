import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/LoginPage/A003ServiceUserAgreements.dart';
import 'package:forutonafront/LoginPage/A004PhoneAuthView.dart';
import 'package:forutonafront/LoginPage/A006SignIn3View.dart';
import 'package:forutonafront/LoginPage/Component/AgreeFieldComponent.dart';
import 'package:forutonafront/LoginPage/Component/SnsLoginDataLogic.dart';

class A002SignIn1View extends StatefulWidget {
  A002SignIn1View({this.userinfomain, Key key}) : super(key: key);
  final UserInfoMain userinfomain;
  @override
  _A002SignIn1ViewState createState() {
    return _A002SignIn1ViewState(userinfomain: userinfomain);
  }
}

class _A002SignIn1ViewState extends State<A002SignIn1View> {
  _A002SignIn1ViewState({this.userinfomain});
  UserInfoMain userinfomain;

  AgreeFieldItem allAgreeItem = AgreeFieldItem(text: "모든 약관에 동의 합니다.");
  AgreeFieldItem serviceAgreeItem = AgreeFieldItem(text: "서비스 이용 약관 동의");
  AgreeFieldItem personalAgreeItem = AgreeFieldItem(text: "개인정보 수집 이용 동의");
  AgreeFieldItem locationAgreeItem = AgreeFieldItem(text: "위치정보 활용 동의");
  AgreeFieldItem marketingAgreeItem =
      AgreeFieldItem(text: "마케팅 정보 메일 수신 동의(선택)");
  AgreeFieldItem ageAgreeItem = AgreeFieldItem(
      text: "만 14세 이상입니다.", subtext: "만 14세 미만의 어린이는 가입을 제한하고 있습니다.");

  @override
  void initState() {
    super.initState();
    allAgreeItem.onchenge = this.onallAgreeItemchange;
    serviceAgreeItem.onchenge = (value) {
      setState(() {});
    };
    personalAgreeItem.onchenge = (value) {
      setState(() {});
    };
    locationAgreeItem.onchenge = (value) {
      setState(() {});
    };
    marketingAgreeItem.onchenge = (value) {
      setState(() {});
    };
    ageAgreeItem.onchenge = (value) {
      setState(() {});
    };
  }

  onallAgreeItemchange(value) {
    serviceAgreeItem.ischecked = value;
    personalAgreeItem.ischecked = value;
    locationAgreeItem.ischecked = value;
    marketingAgreeItem.ischecked = value;
    ageAgreeItem.ischecked = value;
    setState(() {});
  }

  bool checkbutonnext() {
    if (serviceAgreeItem.ischecked &&
        personalAgreeItem.ischecked &&
        locationAgreeItem.ischecked &&
        ageAgreeItem.ischecked) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    serviceAgreeItem.nextpage = MaterialPageRoute(builder: (context) {
      return A003ServiceUserAgreements();
    });
    personalAgreeItem.nextpage = MaterialPageRoute(builder: (context) {
      return A003ServiceUserAgreements();
    });
    locationAgreeItem.nextpage = MaterialPageRoute(builder: (context) {
      return A003ServiceUserAgreements();
    });
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
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "환영합니다!",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto Sans CJK KR',
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "회원이 되기 위해서는 약관에 동의가 필요합니다.",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto Sans CJK KR',
                        fontSize: 13),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFE4E7E8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.00),
                            topRight: Radius.circular(16.00))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 21, 16, 0),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.00, 4.00),
                                color: Color(0xff455b63).withOpacity(0.08),
                                blurRadius: 16,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12.00),
                          ),
                          height: 52,
                          child: AgreeFieldComponent(
                            fielditem: allAgreeItem,
                          ),
                        ),
                        SizedBox(
                          height: 21,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 21),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.00, 4.00),
                                color: Color(0xff455b63).withOpacity(0.08),
                                blurRadius: 16,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12.00),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 52,
                                child: AgreeFieldComponent(
                                  fielditem: serviceAgreeItem,
                                ),
                              ),
                              Divider(
                                color: Color(0xffe4e7e8),
                                height: 1,
                              ),
                              Container(
                                height: 52,
                                child: AgreeFieldComponent(
                                  fielditem: personalAgreeItem,
                                ),
                              ),
                              Divider(
                                color: Color(0xffe4e7e8),
                                height: 1,
                              ),
                              Container(
                                height: 52,
                                child: AgreeFieldComponent(
                                  fielditem: locationAgreeItem,
                                ),
                              ),
                              Divider(
                                color: Color(0xffe4e7e8),
                                height: 1,
                              ),
                              Container(
                                height: 52,
                                child: AgreeFieldComponent(
                                  fielditem: marketingAgreeItem,
                                ),
                              ),
                              Divider(
                                color: Color(0xffe4e7e8),
                                height: 1,
                              ),
                              Container(
                                height: 52,
                                child: AgreeFieldComponent(
                                  fielditem: ageAgreeItem,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 21),
                        checkbutonnext()
                            ? Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 16),
                                child: Container(
                                    height: 37.00,
                                    width: 67.00,
                                    decoration: BoxDecoration(
                                      color: Color(0xff454f63),
                                      border: Border.all(
                                        width: 2.00,
                                        color: Color(0xff39f999),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.00),
                                    ),
                                    child: FlatButton(
                                      child: Text(
                                        "다음",
                                        style: TextStyle(
                                            color: Color(0xff39F999),
                                            fontFamily: 'Noto Sans CJK KR',
                                            fontSize: 16),
                                      ),
                                      onPressed: () {
                                        userinfomain.forutonaagree =
                                            serviceAgreeItem.ischecked ? 1 : 0;
                                        userinfomain.privateagree =
                                            personalAgreeItem.ischecked ? 1 : 0;
                                        userinfomain.positionagree =
                                            locationAgreeItem.ischecked ? 1 : 0;
                                        userinfomain.martketingagree =
                                            marketingAgreeItem.ischecked
                                                ? 1
                                                : 0;
                                        userinfomain.agelimitagree =
                                            ageAgreeItem.ischecked ? 1 : 0;
                                        if (userinfomain.snsservice ==
                                            SnsLoginDataLogic.email) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return A004PhoneAuthView(
                                                userinfomain: userinfomain);
                                          }));
                                        } else {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return A006SignIn3View(
                                                userinfomain: userinfomain);
                                          }));
                                        }
                                      },
                                    )),
                              )
                            : Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 16),
                                child: Container(
                                  height: 37.00,
                                  width: 67.00,
                                  decoration: BoxDecoration(
                                      color: Color(0xffe4e7e8),
                                      border: Border.all(
                                        width: 2.00,
                                        color: Color(0xffcccccc),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.00)),
                                  child: FlatButton(
                                    child: Text(
                                      "다음",
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontFamily: 'Noto Sans CJK KR',
                                          fontSize: 16),
                                    ),
                                    onPressed: () {},
                                  ),
                                )),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ))
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 10,
            child: LinearProgressIndicator(
              value: 0.25,
              backgroundColor: Color(0xffCCCCCC),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF39F999)),
            ),
          ),
        ));
  }
}
