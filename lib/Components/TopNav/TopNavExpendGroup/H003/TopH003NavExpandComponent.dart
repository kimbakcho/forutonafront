import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import '../../TopNavRouterType.dart';
import '../TopNavExpendComponent.dart';

class TopH003NavExpandComponent extends StatefulWidget {
  @override
  _TopH003NavExpandComponentState createState() => _TopH003NavExpandComponentState();
}

class _TopH003NavExpandComponentState extends State<TopH003NavExpandComponent>
    with SingleTickerProviderStateMixin implements TopNavExpendComponent{
  AnimationController _controller;
  TopNavBtnMediator topNavBtnMediator;

  @override
  void initState() {
    topNavBtnMediator = sl();
    topNavBtnMediator.topNavExpendRegisterComponent(this);
    iniAnimation();
    super.initState();
  }

  void iniAnimation() {
    _controller = AnimationController(vsync: this,duration: topNavBtnMediator.animationDuration);
    _controller.forward();
  }

  @override
  void dispose() {
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
      child: TopH003NavExpendAniContent(

      ),
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
}

class TopH003NavExpendAniContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("H003"),);
  }
}

class TopH003NavExpandAniComponent extends StatelessWidget {
  final Animation<double> animation;
  final double btnHeightSize;
  final Widget child;

  const TopH003NavExpandAniComponent({Key key, this.animation, this.btnHeightSize, this.child}) : super(key: key);

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

