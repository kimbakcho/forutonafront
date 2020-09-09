import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';

import 'package:forutonafront/Components/TopNav/TopNavRouterType.dart';

import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import '../TopNavBtnMediator.dart';
import 'TopNavBtnComponent.dart';

class NavBtnComponent extends StatefulWidget {
  final NavBtnSetDto navBtnSetDto;

  NavBtnComponent(
      {Key key,
      this.navBtnSetDto})
      : super(key: key);

  @override
  _NavBtnComponentState createState() => _NavBtnComponentState(navBtnSetDto);
}

class _NavBtnComponentState extends State<NavBtnComponent>
    with SingleTickerProviderStateMixin
    implements TopNavBtnComponent {
  final NavBtnSetDto navBtnSetDto;
  AnimationController _controller;

  final TopNavBtnMediator navBtnMediator = sl();

  _NavBtnComponentState(this.navBtnSetDto);

  @override
  void initState() {
    initAnimation();
    super.initState();
    navBtnMediator.topNavBtnRegisterComponent(this);
  }

  initAnimation() {
    _controller = AnimationController(vsync: this, duration: navBtnSetDto.duration);
  }

  Animation<double> getAnimation() {
    return Tween<double>(begin: navBtnSetDto.startOffset, end: navBtnSetDto.endOffset)
        .animate(_controller);
  }

  @override
  void dispose() {
    navBtnMediator.topNavBtnUnRegisterComponent(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavBtnAniComponent(
      child: NavBtnContent(
        btnColor: navBtnSetDto.btnColor,
        btnIcon: navBtnSetDto.btnIcon,
        navRouterType: navBtnSetDto.routerType,
      ),
      animation: getAnimation(),
      btnSize: navBtnSetDto.btnSize,
    );
  }

  @override
  aniForward() {
    _controller.forward();
  }

  @override
  aniReverse() {
    _controller.reverse();
  }

  @override
  getTopNavRouterType() {
    return navBtnSetDto.routerType;
  }
}

class NavBtnContent extends StatelessWidget {
  final Color btnColor;
  final Icon btnIcon;
  final TopNavRouterType navRouterType;
  final TopNavBtnMediator navBtnMediator = sl();

  NavBtnContent({Key key, this.btnColor, this.btnIcon,this.navRouterType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: btnColor,
          shape: BoxShape.circle,
        ),
        child: FlatButton(
          shape: CircleBorder(),
          padding: EdgeInsets.all(0),
          onPressed: () {
            if(navBtnMediator.aniState == NavBtnMediatorState.Close){
              navBtnMediator.openNavList(navRouterType: navRouterType);
            }else {
              navBtnMediator.closeNavList(navRouterType: navRouterType);
            }
          },
          child: btnIcon,
        ));
  }
}

class NavBtnAniComponent extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double btnSize;

  const NavBtnAniComponent(
      {Key key, this.animation, this.child, this.btnSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Positioned(
        left: animation.value,
        width: btnSize,
        height: btnSize,
        child: child,
      ),
      child: child,
    );
  }
}
