import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/LoginPage/Component/SignInItem.dart';

import 'Component/DropDownPicker.dart';

class SignIn3View extends StatefulWidget {
  SignIn3View({Key key, @required this.signitem}) : super(key: key);
  final Signitem signitem;
  @override
  _SignIn3ViewState createState() => _SignIn3ViewState();
}

class _SignIn3ViewState extends State<SignIn3View> {
  TextEditingController nickNameController = TextEditingController();
  DateTime yearpickervalue = DateTime.now();
  int yeardownvalue = DateTime.now().year;
  int monthdownvalue = 1;
  int daydownvalue = 1;
  List<int> yearslist = List<int>();
  List<int> monthlist = List<int>();
  List<int> daylist = List<int>();
  var dateUtility = new DateUtil();
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      yearslist.add(DateTime.now().year - i);
    }
    for (var i = 1; i <= 12; i++) {
      monthlist.add(i);
    }
    daylist = _makedaylist(yeardownvalue, monthdownvalue);
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
          titleSpacing: 0,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("<"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.15, 20, 20),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: ListView(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          print("123");
                        },
                        child: Container(
                          //width: 100.0,
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: new BoxDecoration(
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.circle),
                          child: new Center(
                              child: new Icon(Icons.add_photo_alternate,
                                  size: MediaQuery.of(context).size.height *
                                      0.07)),
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
                        this.widget.signitem.emailID = value;
                      },
                    ),
                    Container(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: DropDownPicker(
                              value: yeardownvalue,
                              items: yearslist,
                              onchange: (value) {
                                yeardownvalue = value;
                                setState(() {
                                  daydownvalue = 1;
                                  daylist = _makedaylist(
                                      yeardownvalue, monthdownvalue);
                                });
                              }),
                        ),
                        Container(
                          width: 20,
                        ),
                        Container(
                          width: 100,
                          child: DropDownPicker(
                              value: monthdownvalue,
                              items: monthlist,
                              onchange: (value) {
                                monthdownvalue = value;
                                setState(() {
                                  daydownvalue = 1;
                                  daylist = _makedaylist(
                                      yeardownvalue, monthdownvalue);
                                });
                              }),
                        ),
                        Container(
                          width: 20,
                        ),
                        Container(
                          width: 100,
                          child: DropDownPicker(
                              value: daydownvalue,
                              items: daylist,
                              onchange: (value) {
                                daydownvalue = value;
                              }),
                        )
                      ],
                    ),
                    Container(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                          child: Text('남성'),
                          onPressed: () {},
                        )),
                        Container(
                          width: 5,
                        ),
                        Expanded(
                          child: RaisedButton(
                            child: Text('여성'),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    child: Text('Complete'),
                    onPressed: () {},
                  ),
                )
              ],
            )));
  }
}
