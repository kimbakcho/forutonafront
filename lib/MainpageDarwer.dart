import 'package:flutter/material.dart';
import 'package:forutonafront/globals.dart';

class MainpageDarwer extends StatefulWidget {
  MainpageDarwer({Key key}) : super(key: key);

  @override
  _MainpageDarwerState createState() => _MainpageDarwerState();
}

class _MainpageDarwerState extends State<MainpageDarwer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: DrawerHeader(
                child: Center(
                    child: CircleAvatar(
                  maxRadius: 80,
                  backgroundImage: GolobalStateContainer.of(context)
                              .state
                              .userInfoMain
                              .profilepicktureurl
                              .length ==
                          0
                      ? AssetImage("assets/basicprofileimage.png")
                      : NetworkImage(GolobalStateContainer.of(context)
                          .state
                          .userInfoMain
                          .profilepicktureurl),
                )),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              )),
          Container(
            height: 30,
            child: FlatButton(
              child: Container(
                alignment: Alignment(-1, 0),
                child: Text("프로필 수정"),
              ),
              onPressed: () {},
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            height: 30,
            child: FlatButton(
              child: Container(
                alignment: Alignment(-1, 0),
                child: Text("포인트 상세내역"),
              ),
              onPressed: () {},
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            height: 30,
            child: FlatButton(
              child: Container(
                alignment: Alignment(-1, 0),
                child: Text("설정"),
              ),
              onPressed: () {},
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            height: 30,
            child: FlatButton(
              child: Container(
                alignment: Alignment(-1, 0),
                child: Text("고객센터"),
              ),
              onPressed: () {},
            ),
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
