import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:international_phone_input/international_phone_input.dart';

class A004PhoneAuthView extends StatefulWidget {
  A004PhoneAuthView({this.userinfomain, Key key}) : super(key: key);
  final UserInfoMain userinfomain;
  @override
  _A004PhoneAuthViewState createState() {
    return _A004PhoneAuthViewState(userinfomain: userinfomain);
  }
}

class _A004PhoneAuthViewState extends State<A004PhoneAuthView> {
  _A004PhoneAuthViewState({this.userinfomain});
  UserInfoMain userinfomain;

  onPhoneNumberChange(
      String phoneText, String number, String selectedItemcode) {}
  String phoneNumber = "";

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
                child: Text("가입하기",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'NotoSansKR',
                        fontSize: 24)),
              ),
              SizedBox(
                height: 13,
              ),
              Container(
                alignment: Alignment.center,
                child: Text("먼저,휴대폰 인증이 필요합니다.",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSansKR',
                        fontSize: 13)),
              ),
              SizedBox(height: 17),
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFE4E7E8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.00),
                            topRight: Radius.circular(16.00))),
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                        child: InternationalPhoneInput(
                            onPhoneNumberChange: onPhoneNumberChange,
                            initialPhoneNumber: phoneNumber,
                            hintText: "휴대폰 번호 입력",
                            errorText: "양식에 맞지 않습니다.",
                            initialSelection: "KR"),

                        // TextFormField(
                        //   decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(12)))),
                        // ),
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
                      )
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
