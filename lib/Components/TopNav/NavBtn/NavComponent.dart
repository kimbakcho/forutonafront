import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/TopNavBtnComponent.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/TopNavBtnMediator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class NavComponent extends StatefulWidget {
  final NavBtnSetDto navBtnSetDto;

  NavComponent(
      {Key key,
      this.navBtnSetDto})
      : super(key: key);

  @override
  _NavComponentState createState() => _NavComponentState(navBtnSetDto);
}

class _NavComponentState extends State<NavComponent>
    with SingleTickerProviderStateMixin
    implements TopNavBtnComponent {
  final NavBtnSetDto navBtnSetDto;
  AnimationController _controller;

  final TopNavBtnMediator navBtnMediator = sl();

  _NavComponentState(this.navBtnSetDto);

  @override
  void initState() {
    initAnimation();
    super.initState();
    navBtnMediator.registerComponent(this);
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
    navBtnMediator.unRegisterComponent(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavBtnAniComponent(
      child: NavBtnContent(
        btnColor: navBtnSetDto.btnColor,
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
}

class NavBtnContent extends StatelessWidget {
  final Color btnColor;
  final Icon btnIcon;
  final TopNavBtnMediator navBtnMediator = sl();

  NavBtnContent({Key key, this.btnColor, this.btnIcon}) : super(key: key);

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
              navBtnMediator.openNavList();
            }else {
              navBtnMediator.closeNavList();
            }
          },
          child: Icon(Icons.sort),
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
