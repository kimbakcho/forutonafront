import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapCenterExpendCircle extends StatefulWidget {
  @override
  _MapCenterExpendCircleState createState() => _MapCenterExpendCircleState();
}

class _MapCenterExpendCircleState extends State<MapCenterExpendCircle>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
    super.initState();
  }

  Animation<double> getAnimation() {
    double startCircleRadius = 0;
    return Tween<double>(begin: startCircleRadius, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MapCenterExpendCircleAnimationComponent(
        animation: getAnimation(),
        child: Container(
        ),
      ),
    );
  }
}

class MapCenterExpendCircleAnimationComponent extends StatelessWidget {
  final Animation<double> animation;

  final Widget child;

  const MapCenterExpendCircleAnimationComponent(
      {Key key, this.animation, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff1DE56D).withOpacity(1-animation.value)
        ),
        width: animation.value * (MediaQuery.of(context).size.width - 100),
        height: animation.value * (MediaQuery.of(context).size.width - 100),
        child: child,
      ),
      child: child,
    );
  }
}
