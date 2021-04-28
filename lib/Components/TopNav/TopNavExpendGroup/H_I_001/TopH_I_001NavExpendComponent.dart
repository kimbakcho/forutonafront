import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';

import '../TopNavExpendComponent.dart';
import 'GeoViewSearchManager.dart';
import 'TopH_I_001NavExpendAniContent.dart';
import 'TopH_I_001NavExpendDto.dart';

// ignore: camel_case_types
class TopH_I_001NavExpendComponent extends StatefulWidget {
  final TopH_I_001NavExpendDto? topH001NavExpendDto;
  final TopNavBtnMediator? topNavBtnMediator;
  final CodeMainPageController? codeMainPageController;
  final TopH_I_001NavExpendAniContentController?
      topH_I_001NavExpendAniContentController;

  final GeoViewSearchManagerInputPort? geoViewSearchManager;

  const TopH_I_001NavExpendComponent(
      {Key? key,
      this.topH001NavExpendDto,
      this.topNavBtnMediator,
      this.codeMainPageController,
      this.geoViewSearchManager,
      this.topH_I_001NavExpendAniContentController})
      : super(key: key);

  @override
  _TopH_I_001NavExpendComponentState createState() =>
      _TopH_I_001NavExpendComponentState(
          topNavBtnMediator: this.topNavBtnMediator,
          geoViewSearchManager: geoViewSearchManager,
          codeMainPageController: codeMainPageController,
          topH_I_001NavExpendAniContentController:
              topH_I_001NavExpendAniContentController);
}

// ignore: camel_case_types
class _TopH_I_001NavExpendComponentState
    extends State<TopH_I_001NavExpendComponent>
    with SingleTickerProviderStateMixin
    implements TopNavExpendComponent, CodeMainPageChangeListener {
  AnimationController? _controller;

  @override
  CodeMainPageController? codeMainPageController;

  @override
  TopNavBtnMediator? topNavBtnMediator;

  final GeoViewSearchManagerInputPort? geoViewSearchManager;

  // ignore: non_constant_identifier_names
  TopH_I_001NavExpendAniContent? _topH_I_001NavExpendAniContent;

  final TopH_I_001NavExpendAniContentController?
      topH_I_001NavExpendAniContentController;

  _TopH_I_001NavExpendComponentState(
      {this.topNavBtnMediator,
      this.geoViewSearchManager,
      this.topH_I_001NavExpendAniContentController,
      this.codeMainPageController}) {
    topNavBtnMediator!.topNavExpendRegisterComponent(this);
    _topH_I_001NavExpendAniContent = TopH_I_001NavExpendAniContent(
      geoViewSearchManager: geoViewSearchManager,
      codeMainPageController: codeMainPageController,
      topH_I_001NavExpendAniContentController:
          topH_I_001NavExpendAniContentController,
    );
  }

  @override
  void initState() {
    initAnimation();
    codeMainPageController!.addListener(this);
    super.initState();
  }

  initAnimation() {
    _controller = AnimationController(
        duration: topNavBtnMediator!.animationDuration, vsync: this);
    _controller!.forward();
    _controller!.addStatusListener(setListener);
  }

  void setListener(status) {
    if (status == AnimationStatus.dismissed) {
      _topH_I_001NavExpendAniContent!.collapsed();
    } else if (status == AnimationStatus.forward) {
      _topH_I_001NavExpendAniContent!.expended();
    }
  }

  Animation<double> getAnimation(BuildContext context) {
    double smallSizeBtn = 80;
    return Tween<double>(
            begin: smallSizeBtn, end: widget.topH001NavExpendDto!.btnWidthSize)
        .animate(_controller!);
  }

  @override
  void dispose() {
    codeMainPageController!.removeListener(this);
    topNavBtnMediator!.topNavExpendUnRegisterComponent(this);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopH_I_001NavExpendAniComponent(
      animation: getAnimation(context),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _topH_I_001NavExpendAniContent!,
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xff454F63),
                    width: codeMainPageController!.currentState ==
                            CodeState.I001CODE
                        ? 2
                        : 0),
                color: codeMainPageController!.currentState == CodeState.I001CODE
                    ? Color(0xffFFF170)
                    : Color(0xffF6F6F6),
                shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {
                setState(() {
                  codeMainPageController!.moveToPage(CodeState.I001CODE);
                });
              },
              padding: EdgeInsets.all(0),
              icon: Icon(
                ForutonaIcon.map_alt,
                size: 17,
              ),
            ),
          )
        ],
      ),
      btnHeightSize: widget.topH001NavExpendDto!.btnHeightSize,
    );
  }

  @override
  closeExpandNav() {
    _controller!.reverse();
  }

  @override
  openExpandNav() {
    _controller!.forward();
  }

  @override
  getTopNavRouterType() {
    return CodeState.H001CODE;
  }

  @override
  onChangeMainPage() {
    setState(() {});
  }
}

// ignore: camel_case_types
class TopH_I_001NavExpendAniComponent extends StatelessWidget {
  final Animation<double>? animation;
  final double? btnHeightSize;
  final Widget? child;

  const TopH_I_001NavExpendAniComponent(
      {Key? key, this.animation, this.btnHeightSize, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) => Positioned(
        right: 0,
        top: 0,
        width: animation!.value,
        height: btnHeightSize,
        child: child!,
      ),
      child: child,
    );
  }
}
