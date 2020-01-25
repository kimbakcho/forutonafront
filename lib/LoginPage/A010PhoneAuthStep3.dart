import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/LoginPage/Component/VaildTextFromField.dart';

class A010PhoneAuthStep3 extends StatefulWidget {
  A010PhoneAuthStep3({this.userInfoMain, Key key}) : super(key: key);
  final UserInfoMain userInfoMain;

  @override
  _A010PhoneAuthStep3State createState() {
    return _A010PhoneAuthStep3State(userInfoMain: userInfoMain);
  }
}

class _A010PhoneAuthStep3State extends State<A010PhoneAuthStep3> {
  _A010PhoneAuthStep3State({this.userInfoMain});
  UserInfoMain userInfoMain;

  bool isnext = false;
  VaildTextFromFieldItem pass1vailditem;
  VaildTextFromFieldItem pass2vailditem;

  @override
  void initState() {
    super.initState();
    pass1vailditem = VaildTextFromFieldItem(
        hintText: "새로운 패스워드 입력",
        onchange: (value) {
          this.onchange(value);
        },
        obscureText: true,
        validator: (value) {
          if (value.length < 8) {
            return "패스워드는 최소 8자 이상";
          } else {
            return null;
          }
        });
    pass2vailditem = VaildTextFromFieldItem(
        hintText: "새로운 패스워드 확인",
        onchange: (value) {
          this.onchange(value);
        },
        obscureText: true,
        validator: (value) {
          if (pass1vailditem.text != value) {
            return "패스워드가 다릅니다.";
          } else {
            return null;
          }
        });
  }

  onchange(value) {
    if (pass1vailditem.validator(pass1vailditem.text) == null &&
        pass2vailditem.validator(pass2vailditem.text) == null) {
      isnext = true;
      setState(() {});
    } else {
      isnext = false;
      setState(() {});
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
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0.0,
              title: Text("신규 패스워드 만들기",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NotoSansKR',
                      fontSize: 20)),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
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
                                    fontFamily: 'NotoSansKR',
                                    fontSize: 16),
                              ),
                              onPressed: () async {
                                userInfoMain.password = pass1vailditem.text;
                                int result =
                                    await UserInfoMain.passwrodChangefromphone(
                                        userInfoMain);
                                if (result > 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Container(
                                              child: Text("패스워드 변경 확인")),
                                          content: Container(
                                            height: 100,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "패스워드를 변경하였습니다.",
                                                    style: TextStyle(
                                                      fontFamily: "NotoSansKR",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 14,
                                                      color: Color(0xff454f63),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 21,
                                                ),
                                                Container(
                                                  height: 36.00,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff454f63),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.00),
                                                  ),
                                                  child: FlatButton(
                                                    onPressed: () {
                                                      Navigator.popUntil(
                                                          context,
                                                          ModalRoute.withName(
                                                              '/'));
                                                    },
                                                    child: Text("확인",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "NotoSansKR",
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff39f999),
                                                        )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }
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
                                  fontFamily: 'NotoSansKR',
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
              Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xFFE4E7E8),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.00),
                              topRight: Radius.circular(16.00))),
                      child: Column(children: <Widget>[
                        SizedBox(height: 32),
                        Container(
                            margin: EdgeInsets.only(left: 32),
                            alignment: Alignment.centerLeft,
                            child:
                                Text("새로운 패스워드를 생성합니다.\n패스워드는 8자리 이상을 사용해주세요.",
                                    style: TextStyle(
                                      fontFamily: "NotoSansKR",
                                      fontSize: 14,
                                      color: Color(0xff78849e),
                                    ))),
                        SizedBox(height: 21),
                        Container(
                          margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                          height: 50,
                          child: VaildTextFromField(item: pass1vailditem),
                        ),
                        SizedBox(
                          height: 21,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                          height: 50,
                          child: VaildTextFromField(item: pass2vailditem),
                        )
                      ])))
            ])),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
                height: 10,
                child: LinearProgressIndicator(
                  value: 1,
                  backgroundColor: Color(0xffCCCCCC),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF39F999)),
                ))));
  }
}
