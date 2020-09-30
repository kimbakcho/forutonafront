import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';

import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';

import '../../TopNavRouterType.dart';
import '../TopNavExpendComponent.dart';
import 'TopH_I_001NavExpendAniContent.dart';
import 'TopH_I_001NavExpendDto.dart';

// ignore: camel_case_types
class TopH_I_001NavExpendComponent extends StatefulWidget {
  final TopH_I_001NavExpendDto topH001NavExpendDto;
  final TopNavBtnMediator topNavBtnMediator;
  final CodeMainPageController codeMainPageController;

  const TopH_I_001NavExpendComponent(
      {Key key,
      this.topH001NavExpendDto,
      this.topNavBtnMediator,
      this.codeMainPageController})
      : super(key: key);

  @override
  _TopH_I_001NavExpendComponentState createState() =>
      _TopH_I_001NavExpendComponentState(topNavBtnMediator: this.topNavBtnMediator);
}

// ignore: camel_case_types
class _TopH_I_001NavExpendComponentState extends State<TopH_I_001NavExpendComponent>
    with SingleTickerProviderStateMixin
    implements TopNavExpendComponent {
  AnimationController _controller;

  @override
  TopNavBtnMediator topNavBtnMediator;

  // ignore: non_constant_identifier_names
  TopH_I_001NavExpendAniContent _topH_I_001NavExpendAniContent;

  _TopH_I_001NavExpendComponentState({this.topNavBtnMediator}) {
    topNavBtnMediator.topNavExpendRegisterComponent(this);
    _topH_I_001NavExpendAniContent = TopH_I_001NavExpendAniContent();
  }

  @override
  void initState() {
    initAnimation();

    super.initState();
  }

  initAnimation() {
    _controller = AnimationController(
        vsync: this, duration: topNavBtnMediator.animationDuration);
    _controller.forward();
    _controller.addStatusListener(setListener);
  }

  void setListener(status) {
    if (status == AnimationStatus.dismissed) {
      _topH_I_001NavExpendAniContent.collapsed();
    } else if (status == AnimationStatus.forward) {
      _topH_I_001NavExpendAniContent.expended();
    }
  }

  Animation<double> getAnimation() {
    double smallSizeBtn = 80;
    return Tween<double>(
            begin: smallSizeBtn, end: widget.topH001NavExpendDto.btnWidthSize)
        .animate(_controller);
  }

  @override
  void dispose() {
    topNavBtnMediator.topNavExpendUnRegisterComponent(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopH_I_001NavExpendAniComponent(
      animation: getAnimation(),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _topH_I_001NavExpendAniContent,
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 36,
            height: 36,
            decoration:
                BoxDecoration(color: Color(0xffF6F6F6), shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {
                widget.codeMainPageController.moveToPage(CodeState.I001CODE);
              },
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.map,
                size: 17,
              ),
            ),
          )
        ],
      ),
      btnHeightSize: widget.topH001NavExpendDto.btnHeightSize,
    );
  }

  @override
  closeExpandNav() {
    _controller.reverse();
  }

  @override
  openExpandNav() {
    _controller.forward();
  }

  @override
  getTopNavRouterType() {
    return TopNavRouterType.H_I_001;
  }
}

// ignore: camel_case_types
class TopH_I_001NavExpendAniComponent extends StatelessWidget {
  final Animation<double> animation;
  final double btnHeightSize;
  final Widget child;

  const TopH_I_001NavExpendAniComponent(
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
