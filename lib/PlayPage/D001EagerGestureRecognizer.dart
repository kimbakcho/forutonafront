import 'dart:async';

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
  @override
  void addAllowedPointer(PointerDownEvent event) {
    primaryPointer = event.pointer;
    //startTrackingPointer을 해야 Handler에 CallBack 함수가 실행됨
    startTrackingPointer(event.pointer, event.transform);
    //Timer로 LongPress 확인
    _timer = Timer(_deadline, oninnerLongPress);
  }

  oninnerLongPress() {
    if (currentevent is PointerDownEvent) {
      //gestureaccept 허용과 블록
      gestureaccept = !gestureaccept;
      if (this.onLongPress != null) {
        onLongPress();
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
  void didStopTrackingLastPointer(int pointer) {
    print("didStopTrackingLastPointer");
    print(pointer);
  }

  @override
  void handleEvent(PointerEvent event) {
    // print("handleEvent");
    // print(event);
    currentevent = event;
    if (event is PointerDownEvent) {
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
