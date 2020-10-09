import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';

import '../TopNavExpendComponent.dart';

class TopH003NavExpandComponent extends StatefulWidget {
  final TopNavBtnMediator topNavBtnMediator;
  final CodeMainPageController codeMainPageController;

  const TopH003NavExpandComponent(
      {Key key, this.topNavBtnMediator, this.codeMainPageController})
      : super(key: key);

  @override
  _TopH003NavExpandComponentState createState() =>
      _TopH003NavExpandComponentState(
          topNavBtnMediator: topNavBtnMediator,
          codeMainPageController: codeMainPageController);
}

class _TopH003NavExpandComponentState extends State<TopH003NavExpandComponent>
    with SingleTickerProviderStateMixin
    implements TopNavExpendComponent,CodeMainPageChangeListener {
  AnimationController _controller;

  @override
  TopNavBtnMediator topNavBtnMediator;

  @override
  CodeMainPageController codeMainPageController;

  _TopH003NavExpandComponentState(
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
        vsync: this, duration: topNavBtnMediator.animationDuration);
    _controller.forward();
  }

  @override
  void dispose() {
    codeMainPageController.removeListener(this);
    topNavBtnMediator.topNavExpendUnRegisterComponent(this);
    _controller.dispose();
    super.dispose();
  }

  Animation<double> getAnimation() {
    return Tween<double>(begin: 0, end: 280).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return TopH003NavExpandAniComponent(
      animation: getAnimation(),
      btnHeightSize: 30,
      child: TopH003NavExpendAniContent(),
    );
  }

  @override
  closeExpandNav() {
    _controller.reverse();
  }

  @override
  getTopNavRouterType() {
    return CodeState.H003CODE;
  }

  @override
  openExpandNav() {
    _controller.forward();
  }

  @override
  onChangeMainPage() {
    setState(() {

    });
  }
}

class TopH003NavExpendAniContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("H003"),
    );
  }
}

class TopH003NavExpandAniComponent extends StatelessWidget {
  final Animation<double> animation;
  final double btnHeightSize;
  final Widget child;

  const TopH003NavExpandAniComponent(
      {Key key, this.animation, this.btnHeightSize, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Positioned(
        right: 0,
        top: 4,
        width: animation.value,
        height: btnHeightSize,
        child: child,
      ),
      child: child,
    );
  }
}
