import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/TopNavExpendComponent.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';

class TopG003NavExpandComponent extends StatefulWidget {
  final TopNavBtnMediator? topNavBtnMediator;
  final CodeMainPageController? codeMainPageController;

  const TopG003NavExpandComponent(
      {Key? key, this.topNavBtnMediator, this.codeMainPageController})
      : super(key: key);

  @override
  _TopG003NavExpandComponentState createState() =>
      _TopG003NavExpandComponentState(
          topNavBtnMediator: topNavBtnMediator,
          codeMainPageController: codeMainPageController);
}

class _TopG003NavExpandComponentState extends State<TopG003NavExpandComponent>
    with SingleTickerProviderStateMixin
    implements TopNavExpendComponent, CodeMainPageChangeListener {
  AnimationController? _controller;

  @override
  CodeMainPageController? codeMainPageController;

  @override
  TopNavBtnMediator? topNavBtnMediator;

  _TopG003NavExpandComponentState(
      {required this.topNavBtnMediator, this.codeMainPageController});

  @override
  void initState() {
    codeMainPageController!.addListener(this);
    topNavBtnMediator!.topNavExpendRegisterComponent(this);
    iniAnimation();
    super.initState();
  }

  void iniAnimation() {
    _controller = AnimationController(
        duration: topNavBtnMediator!.animationDuration, vsync: this);
    _controller!.forward();
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
    return TopG003NavExpandAniComponent(
      animation: getAnimation(context),
      btnHeightSize: 30,
      child: TopG003NavExpendContent(),
    );
  }

  @override
  closeExpandNav() {
    _controller!.reverse();
  }

  @override
  getAnimation(BuildContext context) {
    return Tween<double>(begin: 0, end: 280).animate(_controller!);
  }

  @override
  getTopNavRouterType() {
    return CodeState.G003CODE;
  }

  @override
  onChangeMainPage() {
    setState(() {});
  }

  @override
  openExpandNav() {
    _controller!.forward();
  }
}

class TopG003NavExpendContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("G003"),
    );
  }
}

class TopG003NavExpandAniComponent extends StatelessWidget {
  final Animation<double>? animation;
  final double? btnHeightSize;
  final Widget? child;

  const TopG003NavExpandAniComponent(
      {Key? key, this.animation, this.btnHeightSize, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) => Positioned(
        right: 0,
        top: 4,
        width: animation!.value,
        height: btnHeightSize,
        child: child!,
      ),
      child: child,
    );
  }
}
