import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';

class D001EagerGestureRecognizer extends EagerGestureRecognizer {
  D001EagerGestureRecognizer({Duration duration, this.onLongPress}) {
    this._deadline = duration ?? Duration(milliseconds: 500);
  }
  Duration _deadline;
  Function onLongPress;
  bool gestureaccept = false;
  int primaryPointer;
  Timer _timer;
  PointerEvent currentevent;
  PointerEvent primarydownevent;

  @override
  void addAllowedPointer(PointerDownEvent event) {
    print(event);
    primaryPointer = event.pointer;
    primarydownevent = event;
    //startTrackingPointer을 해야 Handler에 CallBack 함수가 실행됨
    startTrackingPointer(event.pointer, event.transform);
    //Timer로 LongPress 확인
    _timer = Timer(_deadline, oninnerLongPress);
  }

  oninnerLongPress() {
    if (currentevent is PointerDownEvent || currentevent is PointerMoveEvent) {
      //gestureaccept 허용과 블록
      double dx =
          primarydownevent.localPosition.dx - currentevent.localPosition.dx;
      double dy =
          primarydownevent.localPosition.dy - currentevent.localPosition.dy;
      double distance = sqrt(pow(dx, 2) + pow(dy, 2));
      print("distance = $distance");
      if (distance < 8.0) {
        gestureaccept = !gestureaccept;
        if (this.onLongPress != null) {
          onLongPress();
        }
      }
    }
    _stopTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    // print("handleEvent");
    // print(event);
    currentevent = event;
    if (event is PointerMoveEvent || event is PointerDownEvent) {
      if (gestureaccept) {
        //GoogleMap으로 이벤트 내려주기
        resolve(GestureDisposition.accepted);
      }
    } else {
      if (gestureaccept) {
        //GoogleMap으로 이벤트 내려주기
        resolve(GestureDisposition.accepted);
      }
      stopTrackingPointer(primaryPointer);
    }
  }
}
