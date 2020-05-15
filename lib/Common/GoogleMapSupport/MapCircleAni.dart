import 'dart:ffi';

import 'package:flutter/material.dart';

import 'MapAniCircleController.dart';

class MapCircleAni extends StatefulWidget {
  final MapAniCircleController circleController;
  MapCircleAni(this.circleController);
  @override
  _MapCircleAniState createState() => _MapCircleAniState();
}

class _MapCircleAniState extends State<MapCircleAni> with TickerProviderStateMixin{
  AnimationController controller;
  Animation curve;
  Animation<double> circleRadius;

  AnimationController controller2;
  Animation curve2;
  Animation<double> circleRadius2;
  @override
  void initState() {
     controller =
      AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
     curve =
      CurvedAnimation(parent: controller, curve: Curves.linear);
     circleRadius = Tween<double>(begin: 0, end: 200.0).animate(curve);
    widget.circleController.circleRadius =circleRadius;
    widget.circleController.aniController = controller;
     controller.addStatusListener((state) {
       if (state == AnimationStatus.completed) {
         controller.reset();
       } else if (state == AnimationStatus.dismissed) {
         controller.forward();
       }
     });

     controller2 =
         AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
     curve2 =
         CurvedAnimation(parent: controller2, curve: Curves.linear);
     circleRadius2 = Tween<double>(begin: 0, end: 200.0).animate(curve2);
     widget.circleController.circleRadius2 =circleRadius2;
     widget.circleController.aniController2 = controller2;
     controller2.addStatusListener((state) {
       if (state == AnimationStatus.completed) {
         controller2.reset();
       } else if (state == AnimationStatus.dismissed) {
         controller2.forward();
       }
     });
    super.initState();
  }
  @override
  void didChangeDependencies() {

    super.didChangeDependencies();

  }
  @override
  void didUpdateWidget(MapCircleAni oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }
}
