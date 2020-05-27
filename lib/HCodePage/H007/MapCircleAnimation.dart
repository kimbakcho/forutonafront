import 'package:flutter/material.dart';

class MapCircleAnimation extends StatefulWidget {
  @override
  _MapCircleAnimationState createState() => _MapCircleAnimationState();
}

class _MapCircleAnimationState extends State<MapCircleAnimation>
    with TickerProviderStateMixin {
  Animation<double> _circle1SizeTween;
  Animation<double> _circle1OpacityTween;
  AnimationController circle1Controller;

  Animation<double> _circle2SizeTween;
  Animation<double> _circle2OpacityTween;
  AnimationController circle2Controller;

  @override
  void initState() {
    super.initState();
    circle1AniInit();
    Circle2AniInit();

    circle1Controller.forward();
    Future.delayed(Duration(milliseconds: 500), () {
      circle2Controller.forward();
    });
  }

  void Circle2AniInit() {
    circle2Controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    Animation circle2SizeCurve =
        CurvedAnimation(parent: circle2Controller, curve: Curves.easeOut);
    _circle2SizeTween =
        Tween<double>(begin: 0, end: 200).animate(circle2SizeCurve);
    _circle2SizeTween
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          circle2Controller.reset();
        } else if (status == AnimationStatus.dismissed) {
          circle2Controller.forward();
        }
      });
    _circle2OpacityTween =
        Tween<double>(begin: 0.65, end: 0.2).animate(circle2SizeCurve);
  }

  Animation circle1AniInit() {
    circle1Controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    Animation circle1SizeCurve =
        CurvedAnimation(parent: circle1Controller, curve: Curves.easeOut);
    _circle1SizeTween =
        Tween<double>(begin: 0, end: 200).animate(circle1SizeCurve);
    _circle1SizeTween
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          circle1Controller.reset();
        } else if (status == AnimationStatus.dismissed) {
          circle1Controller.forward();
        }
      });

    _circle1OpacityTween =
        Tween<double>(begin: 0.65, end: 0.2).animate(circle1SizeCurve);
    return circle1SizeCurve;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
            child: Container(
          width: _circle1SizeTween.value,
          height: _circle1SizeTween.value,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff7AFFAF).withOpacity(_circle1OpacityTween.value)),
        )),
        Center(
          child: Container(
            width: _circle2SizeTween.value,
            height: _circle2SizeTween.value,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff7AFFAF).withOpacity(_circle2OpacityTween.value)),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    circle1Controller.dispose();
    circle2Controller.dispose();
    super.dispose();
  }
}
