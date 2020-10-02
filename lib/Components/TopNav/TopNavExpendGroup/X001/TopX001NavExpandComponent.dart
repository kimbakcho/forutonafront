import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import '../../TopNavRouterType.dart';
import '../TopNavExpendComponent.dart';

class TopX001NavExpandComponent extends StatefulWidget {
  @override
  _TopX001NavExpandComponentState createState() =>
      _TopX001NavExpandComponentState();
}

class _TopX001NavExpandComponentState extends State<TopX001NavExpandComponent>
    with SingleTickerProviderStateMixin implements TopNavExpendComponent {
  AnimationController _controller;

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

  @override
  Widget build(BuildContext context) {
    return TopX001NavExpandAniComponent(
      animation: getAnimation(),
      btnHeightSize: 30,
      child: TopX001NavExpendAniContent(
      ),
    );
  }

  @override
  TopNavBtnMediator topNavBtnMediator;

  @override
  closeExpandNav() {
    _controller.reverse();
  }

  @override
  getTopNavRouterType() {
    return CodeState.X001CODE;
  }

  @override
  openExpandNav() {
    _controller.forward();
  }

  @override
  getAnimation() {
    return Tween<double>(begin: 0, end: 280).animate(_controller);
  }
}
class TopX001NavExpendAniContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("X001"),);
  }
}

class TopX001NavExpandAniComponent extends StatelessWidget {
  final Animation<double> animation;
  final double btnHeightSize;
  final Widget child;

  const TopX001NavExpandAniComponent({Key key, this.animation, this.btnHeightSize, this.child}) : super(key: key);

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
