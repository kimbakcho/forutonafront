import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/TopNavExpendComponent.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/Page/GCodePage/G009/G009MainPage.dart';


class TopG001NavExpandComponent extends StatefulWidget {
  final TopNavBtnMediator topNavBtnMediator;
  final CodeMainPageController codeMainPageController;

  const TopG001NavExpandComponent(
      {Key key, this.topNavBtnMediator, this.codeMainPageController})
      : super(key: key);

  @override
  _TopG001NavExpandComponentState createState() =>
      _TopG001NavExpandComponentState(
          topNavBtnMediator: topNavBtnMediator,
          codeMainPageController: codeMainPageController);
}

class _TopG001NavExpandComponentState extends State<TopG001NavExpandComponent>
    with SingleTickerProviderStateMixin
    implements TopNavExpendComponent, CodeMainPageChangeListener {
  AnimationController _controller;

  @override
  CodeMainPageController codeMainPageController;

  @override
  TopNavBtnMediator topNavBtnMediator;

  _TopG001NavExpandComponentState(
      {@required this.topNavBtnMediator, this.codeMainPageController});

  @override
  void initState() {
    codeMainPageController.addListener(this);
    topNavBtnMediator.topNavExpendRegisterComponent(this);
    iniAnimation();
    super.initState();
  }

  void iniAnimation() {
    _controller = AnimationController(
        duration: topNavBtnMediator.animationDuration, vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    codeMainPageController.removeListener(this);
    topNavBtnMediator.topNavExpendUnRegisterComponent(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopG001NavExpandAniComponent(
      animation: getAnimation(context),
      btnHeightSize: 36,
      child: TopG001NavExpendContent(),
    );
  }

  @override
  closeExpandNav() {
    _controller.reverse();
  }

  @override
  getAnimation(BuildContext context) {
    return Tween<double>(begin: 0, end: 52).animate(_controller);
  }

  @override
  getTopNavRouterType() {
    return CodeState.G001CODE;
  }

  @override
  onChangeMainPage() {
    setState(() {});
  }

  @override
  openExpandNav() {
    _controller.forward();
  }
}

class TopG001NavExpendContent extends StatelessWidget {



  const TopG001NavExpendContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        shape: CircleBorder(),
        color: Color(0xffF6F6F6),
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_){
              return G009MainPage();
            }));
          },
            child: Icon(
            ForutonaIcon.cog_g001_1,
            size: 25,
              color: Color(0xffB1B1B1),
            ),
        ),
      ),
    );
  }
}

class TopG001NavExpandAniComponent extends StatelessWidget {
  final Animation<double> animation;
  final double btnHeightSize;
  final Widget child;

  const TopG001NavExpandAniComponent(
      {Key key, this.animation, this.btnHeightSize, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Positioned(
        right: 0,
        top: 0,
        width: animation.value,
        height: btnHeightSize,
        child: child,
      ),
      child: child,
    );
  }
}
