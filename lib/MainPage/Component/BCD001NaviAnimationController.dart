import 'dart:math';

import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';

class BCD001NaviAnimationController extends FlareController {
  ActorAnimation _processAnimation;
  double _currentProcessValue = 0.0;
  double _processValue = 0.0;
  double _speed = 5.0;
  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _currentProcessValue +=
        (_processValue - _currentProcessValue) * min(1, elapsed * _speed);
    _processAnimation.apply(
        _currentProcessValue % _processAnimation.duration, artboard, 1);

    return true;
  }

  set processValue(double value) {
    // if (value > 1.5) {
    //   this._processValue = 0.5;
    //   this._currentProcessValue = 0;
    // } else {
    this._processValue = value;
    // }
  }

  get processValue {
    return this._processValue;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    _processAnimation = artboard.getAnimation("play");
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
