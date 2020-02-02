import 'dart:math';

import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

enum NaviPosition { home, make, paly }

class BCD001NaviAnimationController extends FlareController {
  ActorAnimation _processAnimation;
  double _currentProcessValue = 0.0;
  double _processValue = 0.0;
  double _speed = 5.0;
  String tapSource;
  NaviPosition currentNavipostion = NaviPosition.home;
  Function(NaviPosition) onChangeNaviPostion;
  // static const double FPS = 60;

  BCD001NaviAnimationController({this.onChangeNaviPostion});

  FlareAnimationLayer layer;
  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _currentProcessValue +=
        (_processValue - _currentProcessValue) * min(1, elapsed * _speed);
    layer.time = (_currentProcessValue % _processAnimation.duration);
    layer.mix = 1;
    layer.apply(artboard);
    return true;
  }

  set processValue(double value) {
    this._processValue = value;
    double positionvalue = value % _processAnimation.duration;
    if (positionvalue == 0) {
      currentNavipostion = NaviPosition.home;
    } else if (positionvalue == 0.5) {
      currentNavipostion = NaviPosition.make;
    } else if (positionvalue == 1.0) {
      currentNavipostion = NaviPosition.paly;
    }
    onChangeNaviPostion(currentNavipostion);
    // print(positionvalue);
  }

  get processValue {
    return this._processValue;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    _processAnimation = artboard.getAnimation("play");
    layer = FlareAnimationLayer()..animation = _processAnimation;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
