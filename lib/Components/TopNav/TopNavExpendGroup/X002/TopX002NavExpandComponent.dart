import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import '../../TopNavRouterType.dart';
import '../TopNavExpendComponent.dart';

class TopX002NavExpandComponent extends StatefulWidget {
  @override
  _TopX002NavExpandComponentState createState() =>
      _TopX002NavExpandComponentState();
}

class _TopX002NavExpandComponentState extends State<TopX002NavExpandComponent>
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
    return TopX002NavExpandAniComponent(
      animation: getAnimation(),
      btnHeightSize: 30,
      child: TopX002NavExpendAniContent(
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
}
class TopX002NavExpendAniContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("X002"),);
  }
}

class TopX002NavExpandAniComponent extends StatelessWidget {
  final Animation<double> animation;
  final double btnHeightSize;
  final Widget child;

  const TopX002NavExpandAniComponent({Key key, this.animation, this.btnHeightSize, this.child}) : super(key: key);

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
