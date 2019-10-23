import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'MainPage/Component/HomeNavi.dart';
import 'MainPage/Component/HomeNaviInter.dart';
import 'LoginPage/LoginPageView.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  HomeNaviInter naviitme;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    naviitme = HomeNaviInter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.076,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black54,
                width: 1.0,
              )),
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              child: FlatButton(
                child: Text(
                  "Log in",
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPageView();
                  }));
                },
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.076,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black54,
                  width: 1.0,
                )),
                child: Center(
                  child: HomeNavi(
                    parentitem: naviitme,
                    onclickbutton: () => {},
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.076,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black54,
                width: 1.0,
              )),
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              child: FlatButton(
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () => {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
