import 'package:flutter/material.dart';
import 'package:forutonafront/LoginPage/Component/AgreeFieldComponent.dart';

class A002SignIn1View extends StatefulWidget {
  A002SignIn1View({Key key}) : super(key: key);

  @override
  _A002SignIn1ViewState createState() => _A002SignIn1ViewState();
}

class _A002SignIn1ViewState extends State<A002SignIn1View> {
  AgreeFieldItem allAgreeItem = AgreeFieldItem(text: "모든 약관에 동의 합니다.");

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
                        fontFamily: 'NotoSansKR',
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
                        fontFamily: 'NotoSansKR',
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
                          height: 100,
                          child: AgreeFieldComponent(
                            fielditem: allAgreeItem,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
