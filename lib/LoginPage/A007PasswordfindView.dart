import 'package:flutter/material.dart';
import 'package:forutonafront/LoginPage/A008PhoneAuthStep1.dart';
import 'package:forutonafront/LoginPage/A011PassFindEmailStep1.dart';

class A007PasswordfindView extends StatefulWidget {
  A007PasswordfindView({Key key}) : super(key: key);

  @override
  _A007PasswordfindViewState createState() => _A007PasswordfindViewState();
}

class _A007PasswordfindViewState extends State<A007PasswordfindView> {
  bool isnext = false;
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
              title: Text("패스워드 찾기",
                  style: TextStyle(
                    fontFamily: "NotoSansKR",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xffffffff),
                  )),
              titleSpacing: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              )),
          backgroundColor: Colors.transparent,
          body: Container(
              child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFE4E7E8),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.00),
                          topRight: Radius.circular(16.00))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                        width: MediaQuery.of(context).size.width,
                        height: 171,
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
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: 65,
                              child: Text("휴대폰 인증하기",
                                  style: TextStyle(
                                    fontFamily: "NotoSansKR",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xff454f63),
                                  )),
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              alignment: Alignment.centerLeft,
                              child: Text("계정에 등록된 휴대폰 번호를 인증\n하고 패스워드를 변경합니다.",
                                  style: TextStyle(
                                    fontFamily: "NotoSansKR",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                    color: Color(0xff78849e),
                                  )),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(right: 16),
                              child: Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                    color: Color(0xff454F63),
                                    shape: BoxShape.circle),
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return A008PhoneAuthStep1();
                                    }));
                                  },
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 22,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                        width: MediaQuery.of(context).size.width,
                        height: 171,
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
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: 65,
                              child: Text("이메일주소 인증하기",
                                  style: TextStyle(
                                    fontFamily: "NotoSansKR",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xff454f63),
                                  )),
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              alignment: Alignment.centerLeft,
                              child:
                                  Text("계정으로 사용한 이메일 주소를 인\n증하고 패스워드를 변경합니다.",
                                      style: TextStyle(
                                        fontFamily: "NotoSansKR",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                        color: Color(0xff78849e),
                                      )),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(right: 16),
                              child: Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                    color: Color(0xff454F63),
                                    shape: BoxShape.circle),
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return A011PassFindEmailStep1();
                                    }));
                                  },
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 22,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ))),
    );
  }
}
