import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:country_pickers/country_pickers.dart';

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
  @override
  void initState() {
    super.initState();
    userimage = AssetImage("assets/MainImage/emptyuser.png");
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
          title: Text("가입하기",
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
                                fontFamily: 'NotoSansKR',
                                fontSize: 16),
                          ),
                          onPressed: () async {}),
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
          Container(
            child: Text("거의 다 왔습니다!",
                style: TextStyle(
                  fontFamily: "NotoSansKR",
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
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 53,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(16, 0, 8, 0),
                                child: CountryPickerDropdown(
                                  initialValue: userinfomain.isocode,
                                  itemBuilder: _buildDropdownItem,
                                  onValuePicked: (Country country) {
                                    print("${country.name}");
                                  },
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.only(right: 16),
                                child: TextField(
                                    decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "닉네임 입력",
                                  hintStyle: TextStyle(
                                    fontFamily: "NotoSansKR",
                                    fontSize: 15,
                                    color: Color(0xff78849e).withOpacity(0.56),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0))),
                                )),
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
                        border: Border.all(color: Color(0xff78849E), width: 1),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: userimage),
                        shape: BoxShape.circle),
                    child: FlatButton(
                      shape: CircleBorder(),
                      child: Container(),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          )
        ])),
      ),
    );
  }
}
