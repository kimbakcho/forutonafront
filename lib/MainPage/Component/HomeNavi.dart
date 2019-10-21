import 'package:flutter/material.dart';

import 'HomeNaviInter.dart';

class HomeNavi extends StatefulWidget {
  HomeNavi({Key key, this.parentitem, this.onclickbutton}) : super(key: key);
  final HomeNaviInter parentitem;
  final Function onclickbutton;

  _HomeNaviState createState() => _HomeNaviState();
}

class _HomeNaviState extends State<HomeNavi>
    with SingleTickerProviderStateMixin {
  Tween<double> homeAnimation;
  Tween<double> makeAnimation;
  Tween<double> playAnimation;
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animationsetting(this.widget.parentitem.btnmode);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceInOut)
          ..addListener(() {
            setState(() {});
          });
    animationController.forward();
  }

  void animationsetting(String mode) {
    if (mode == HomeNaviInter.makeMode) {
      makeAnimation = Tween<double>(begin: 0.03, end: 0.05);
    } else {
      makeAnimation = Tween<double>(begin: 0.03, end: 0.03);
    }
    if (mode == HomeNaviInter.homeMode) {
      homeAnimation = Tween<double>(begin: 0.03, end: 0.05);
    } else {
      homeAnimation = Tween<double>(begin: 0.03, end: 0.03);
    }

    if (mode == HomeNaviInter.palyMode) {
      playAnimation = Tween<double>(begin: 0.03, end: 0.05);
    } else {
      playAnimation = Tween<double>(begin: 0.03, end: 0.03);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.height *
                makeAnimation.evaluate(animation),
            height: MediaQuery.of(context).size.height *
                makeAnimation.evaluate(animation),
            child: RaisedButton(
              padding: EdgeInsets.all(0),
              child: Text("m"),
              onPressed: () {
                this.widget.parentitem.btnmode = HomeNaviInter.makeMode;
                animationsetting(HomeNaviInter.makeMode);
                animationController.reset();
                animationController.forward();
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.height *
                homeAnimation.evaluate(animation),
            height: MediaQuery.of(context).size.height *
                homeAnimation.evaluate(animation),
            child: RaisedButton(
              padding: EdgeInsets.all(0),
              child: Text("h"),
              onPressed: () {
                this.widget.parentitem.btnmode = HomeNaviInter.homeMode;
                animationsetting(HomeNaviInter.homeMode);
                animationController.reset();
                animationController.forward();
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.height *
                playAnimation.evaluate(animation),
            height: MediaQuery.of(context).size.height *
                playAnimation.evaluate(animation),
            child: RaisedButton(
              padding: EdgeInsets.all(0),
              child: Text("p"),
              onPressed: () {
                this.widget.parentitem.btnmode = HomeNaviInter.palyMode;
                animationsetting(HomeNaviInter.palyMode);
                animationController.reset();
                animationController.forward();
              },
            ),
          ),
        ],
      ),
    );
  }
}
