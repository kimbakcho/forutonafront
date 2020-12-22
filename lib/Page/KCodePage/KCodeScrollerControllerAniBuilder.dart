import 'package:flutter/material.dart';

class KCodeScrollerControllerAniBuilder extends StatefulWidget {
  final double startPosition;
  final double endPosition;
  final KCodeScrollerController controller;
  final Widget child;

  const KCodeScrollerControllerAniBuilder(
      {Key key, this.startPosition, this.endPosition, this.controller, this.child})
      : super(key: key);

  @override
  _KCodeScrollerControllerAniBuilderState createState() =>
      _KCodeScrollerControllerAniBuilderState(scrollerController: controller,child: child);
}

class _KCodeScrollerControllerAniBuilderState extends State<KCodeScrollerControllerAniBuilder>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final KCodeScrollerController scrollerController;
  final Widget child;

  _KCodeScrollerControllerAniBuilderState({@required this.scrollerController,@required this.child});

  @override
  void initState() {
    _controller =
        AnimationController( duration: Duration(milliseconds: 500),vsync: this);
    scrollerController._kCodeScrollerControllerBtnState = this;
    super.initState();
  }

  Animation<double> getAnimation() {
    return Tween<double>(begin: widget.startPosition, end: widget.endPosition)
        .animate(_controller);
  }

  void forward() {
    _controller.forward();
  }

  void reverse() {
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KCodeScrollerControllerBtnAniComponent(
        animation: getAnimation(), scrollerController: scrollerController,aniChild: child);
  }
}

class KCodeScrollerControllerBtnAniComponent extends StatelessWidget {
  final Animation<double> animation;
  final KCodeScrollerController scrollerController;
  final Widget aniChild;
  const KCodeScrollerControllerBtnAniComponent(
      {Key key, this.animation, this.scrollerController, this.aniChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Positioned(
              child: aniChild,
              right: 16,
              bottom: animation.value,
            ));
  }
}

class KCodeScrollerController {
  _KCodeScrollerControllerAniBuilderState _kCodeScrollerControllerBtnState;


  void forward() {
    _kCodeScrollerControllerBtnState.forward();
  }

  void reverse() {
    _kCodeScrollerControllerBtnState.reverse();
  }
}
