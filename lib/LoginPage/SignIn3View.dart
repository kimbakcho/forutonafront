import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfo.dart' as forutona;
import 'package:intl/intl.dart';
import 'Component/DropDownPicker.dart';

class SignIn3View extends StatefulWidget {
  SignIn3View({Key key, this.userinfo, this.loginpage}) : super(key: key);
  final forutona.UserInfo userinfo;
  final String loginpage;
  @override
  _SignIn3ViewState createState() {
    return _SignIn3ViewState(userinfo: userinfo, loginpage: loginpage);
  }
}

class _SignIn3ViewState extends State<SignIn3View> {
  forutona.UserInfo userinfo;
  String loginpage;
  _SignIn3ViewState({
    this.loginpage,
    this.userinfo,
  });

  TextEditingController nickNameController = TextEditingController();

  List<int> yearslist = List<int>();
  List<int> monthlist = List<int>();
  List<int> daylist = List<int>();
  var dateUtility = new DateUtil();
  DropDwonPickerItem yearitem;
  DropDwonPickerItem monthitem;
  DropDwonPickerItem dayitem;
  bool isman = false;
  bool iswoman = false;
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
    if (loginpage == "Email") {
      inityear = DateTime.now().year;
      initmonth = 1;
      initday = 1;
    } else if (loginpage == "Naver") {
      List<String> dateitem = userinfo.agedate.split("-");
      inityear = int.tryParse(dateitem[0]);
      initmonth = int.tryParse(dateitem[1]);
      initday = int.tryParse(dateitem[2]);
      if (userinfo.sex == 1) {
        isman = true;
        iswoman = false;
      } else if (userinfo.sex == 2) {
        iswoman = true;
        isman = false;
      }
      nickNameController.text = userinfo.nickname;
    }
    yearitem = DropDwonPickerItem(
        items: yearslist,
        value: inityear,
        onchange: (value) {
          userinfo.agedate = DateFormat("yyyy-MM-dd")
              .format(DateTime.utc(value, monthitem.value, dayitem.value));
          setState(() {
            dayitem.value = 1;
            dayitem.items = _makedaylist(value, monthitem.value);
          });
        });
    monthitem = DropDwonPickerItem(
        items: monthlist,
        value: initmonth,
        onchange: (value) {
          userinfo.agedate = DateFormat("yyyy-MM-dd")
              .format(DateTime.utc(yearitem.value, value, dayitem.value));
          setState(() {
            dayitem.value = 1;
            dayitem.items = _makedaylist(yearitem.value, monthitem.value);
          });
        });
    dayitem = DropDwonPickerItem(
        value: initday,
        items: daylist,
        onchange: (value) {
          userinfo.agedate = DateFormat("yyyy-MM-dd")
              .format(DateTime.utc(yearitem.value, monthitem.value, value));
        });

    userinfo.agedate = DateFormat("yyyy-MM-dd")
        .format(DateTime.utc(yearitem.value, monthitem.value, dayitem.value));
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
        ),
        body: new Builder(builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.15, 20, 20),
            child: ListView(
              children: <Widget>[
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      //width: 100.0,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: new BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.circle),
                      child: new Center(
                          child: new Icon(Icons.add_photo_alternate,
                              size: MediaQuery.of(context).size.height * 0.07)),
                    )),
                Container(height: 50),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: DropDownPicker(
                        items: yearitem,
                      ),
                    ),
                    Container(
                      width: 20,
                    ),
                    Container(
                      width: 100,
                      child: DropDownPicker(
                        items: monthitem,
                      ),
                    ),
                    Container(
                      width: 20,
                    ),
                    Container(
                      width: 100,
                      child: DropDownPicker(
                        items: dayitem,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          value: isman,
                          onChanged: (value) {
                            if (value) {
                              isman = value;
                              iswoman = false;
                              setState(() {
                                userinfo.sex = 1;
                              });
                            } else {
                              setState(() {
                                isman = value;
                              });
                            }
                          },
                        ),
                        Text("남성")
                      ],
                    )),
                    Container(
                      width: 5,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          value: iswoman,
                          onChanged: (value) {
                            if (value) {
                              setState(() {
                                iswoman = value;
                                isman = false;
                                userinfo.sex = 2;
                              });
                            } else {
                              setState(() {
                                iswoman = value;
                              });
                            }
                          },
                        ),
                        Text("여성")
                      ],
                    )),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: RaisedButton(
                    child: Text('Complete'),
                    onPressed: () async {
                      if (userinfo.nickname.trim().length == 0) {
                        final snackBar = SnackBar(
                          content: Text("닉네임이 없습니다."),
                          duration: Duration(milliseconds: 1000),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        return;
                      }
                      if (!isman && !iswoman) {
                        final snackBar = SnackBar(
                          content: Text("성별이 선택되지 않았습니다."),
                          duration: Duration(milliseconds: 1000),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        return;
                      }
                      int result =
                          await forutona.UserInfo.insertUserInfo(userinfo);
                      if (result == 0) {
                        final snackBar = SnackBar(
                          content: Text("전산에 오류가 생겼습니다."),
                          duration: Duration(milliseconds: 1000),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        return;
                      } else if (result == 1) {
                        final snackBar = SnackBar(
                          content: Text("축하 힙니다."),
                          duration: Duration(milliseconds: 1000),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        await Future.delayed(Duration(seconds: 1));
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      }
                    },
                  ),
                )
              ],
            ),
          );
        }));
  }
}
