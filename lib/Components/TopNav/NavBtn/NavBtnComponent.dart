import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';
import 'package:forutonafront/Components/TopNav/TopNavRouterType.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import '../TopNavBtnMediator.dart';
import 'TopNavBtnComponent.dart';

class NavBtnComponent extends StatefulWidget {
  final NavBtnSetDto navBtnSetDto;

  NavBtnComponent({Key key, this.navBtnSetDto}) : super(key: key);

  @override
  _NavBtnComponentState createState() => _NavBtnComponentState(navBtnSetDto: navBtnSetDto,navBtnMediator: sl());
}

class _NavBtnComponentState extends State<NavBtnComponent>
    with SingleTickerProviderStateMixin
    implements TopNavBtnComponent {
  final NavBtnSetDto navBtnSetDto;
  AnimationController _controller;

  final TopNavBtnMediator navBtnMediator;

  _NavBtnComponentState({this.navBtnSetDto, this.navBtnMediator});

  @override
  void initState() {
    initAnimation();
    super.initState();
    navBtnMediator.topNavBtnRegisterComponent(this);
  }

  initAnimation() {
    _controller = AnimationController(
        vsync: this, duration: navBtnMediator.animationDuration);
    _controller.addStatusListener((status) {
      navBtnMediator.onNavBtnAniStatusListener(status, navBtnSetDto.routerType);
    });
  }

  Animation<double> getAnimation() {
    return Tween<double>(
            begin: navBtnSetDto.startOffset, end: navBtnSetDto.endOffset)
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
        navBtnMediator: navBtnMediator,
        btnColor: navBtnSetDto.btnColor,
        btnIcon: navBtnSetDto.btnIcon,
        navRouterType: navBtnSetDto.routerType,
        topOnMoveMainPage: navBtnSetDto.topOnMoveMainPage,
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

class NavBtnContent extends StatelessWidget implements NavBtnContentInputPort {
  final Color btnColor;
  final Icon btnIcon;
  final TopNavRouterType navRouterType;
  final CodeState topOnMoveMainPage;

  final TopNavBtnMediator navBtnMediator;

  NavBtnContent(
      {Key key,
      this.btnColor,
      this.btnIcon,
      this.navRouterType,
      this.topOnMoveMainPage,
      @required this.navBtnMediator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff454F63), width: 2),
          color: btnColor,
          shape: BoxShape.circle,
        ),
        child: FlatButton(
          shape: CircleBorder(),
          padding: EdgeInsets.all(0),
          onPressed: () {
            onNavTopBtnTop();
          },
          child: btnIcon,
        ));
  }

  void onNavTopBtnTop() {
    if (navBtnMediator.aniState == NavBtnMediatorState.Close) {
      navBtnMediator.openNavList(navRouterType: navRouterType);
    } else {
      navBtnMediator.closeNavList(navRouterType: navRouterType);
      navBtnMediator.changeMainPage(topOnMoveMainPage);
    }
  }
}

abstract class NavBtnContentInputPort {
  onNavTopBtnTop();
}

class NavBtnAniComponent extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double btnSize;

  const NavBtnAniComponent({Key key, this.animation, this.child, this.btnSize})
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
