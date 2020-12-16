import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';

import '../TopNavExpendComponent.dart';

class TopX002NavExpandComponent extends StatefulWidget {
  final TopNavBtnMediator topNavBtnMediator;

  final CodeMainPageController codeMainPageController;

  const TopX002NavExpandComponent(
      {Key key, this.topNavBtnMediator, this.codeMainPageController})
      : super(key: key);

  @override
  _TopX002NavExpandComponentState createState() =>
      _TopX002NavExpandComponentState(
          topNavBtnMediator: topNavBtnMediator,
          codeMainPageController: codeMainPageController);
}

class _TopX002NavExpandComponentState extends State<TopX002NavExpandComponent>
    with SingleTickerProviderStateMixin
    implements TopNavExpendComponent,CodeMainPageChangeListener {
  AnimationController _controller;
  @override
  TopNavBtnMediator topNavBtnMediator;

  @override
  CodeMainPageController codeMainPageController;

  _TopX002NavExpandComponentState(
      {this.topNavBtnMediator, this.codeMainPageController});

  @override
  void initState() {
    codeMainPageController.addListener(this);
    topNavBtnMediator.topNavExpendRegisterComponent(this);
    iniAnimation();
    super.initState();
  }

  void iniAnimation() {
    _controller = AnimationController(
         duration: topNavBtnMediator.animationDuration,vsync: this);
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
    return TopX002NavExpandAniComponent(
      animation: getAnimation(),
      btnHeightSize: 30,
      child: TopX002NavExpendAniContent(),
    );
  }

  @override
  closeExpandNav() {
    _controller.reverse();
  }

  @override
  getTopNavRouterType() {
    return CodeState.X002CODE;
  }

  @override
  openExpandNav() {
    _controller.forward();
  }

  @override
  getAnimation() {
    return Tween<double>(begin: 0, end: 280).animate(_controller);
  }

  @override
  onChangeMainPage() {
    setState(() {

    });
  }
}

class TopX002NavExpendAniContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("X002"),
    );
  }
}

class TopX002NavExpandAniComponent extends StatelessWidget {
  final Animation<double> animation;
  final double btnHeightSize;
  final Widget child;

  const TopX002NavExpandAniComponent(
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
