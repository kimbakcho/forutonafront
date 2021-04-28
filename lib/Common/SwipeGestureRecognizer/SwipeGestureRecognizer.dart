import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

class SwipeGestureRecognizer extends StatefulWidget {
  final Function()? onSwipeLeft;
  final Function()? onSwipeRight;
  final Function()? onSwipeUp;
  final Function()? onSwipeDown;
  final Widget? child;
  final SwipeGestureRecognizerController? swipeGestureRecognizerController;
  SwipeGestureRecognizer({
    Key? key,
    this.child,
    this.onSwipeDown,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp, this.swipeGestureRecognizerController,
  }) : super(key: key);

  @override
  _SwipeGestureRecognizerState createState() => _SwipeGestureRecognizerState();
}

class _SwipeGestureRecognizerState extends State<SwipeGestureRecognizer> {
  Offset? _horizontalSwipeStartingOffset;
  Offset? _verticalSwipeStartingOffset;
  bool _enableGesture = true;
  bool? _isSwipeLeft;
  bool? _isSwipeRight;
  bool? _isSwipeUp;
  bool? _isSwipeDown;

  _SwipeGestureRecognizerState();

  @override
  void initState() {
    super.initState();
    widget.swipeGestureRecognizerController!.swipeGestureRecognizer = this;
    _horizontalSwipeStartingOffset =
        _horizontalSwipeStartingOffset = Offset(0, 0);
    _isSwipeDown = _isSwipeUp = _isSwipeRight = _isSwipeLeft = false;
  }

  _gestureOn(){
    _enableGesture = true;
    setState(() {

    });

  }

  _gestureOff(){
    _enableGesture = false;
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    if(!_enableGesture){
      return GestureDetector(
        child: widget.child,
      );
    }
    return (widget.onSwipeLeft != null || widget.onSwipeRight != null) &&
        (widget.onSwipeDown != null || widget.onSwipeUp != null)
        ? GestureDetector(
      child: widget.child,
      onHorizontalDragStart: (details) {
        _horizontalSwipeStartingOffset = details.localPosition;
      },
      onHorizontalDragUpdate: (details) {
        if (_horizontalSwipeStartingOffset!.dx >
            details.localPosition.dx) {
          _isSwipeLeft = true;
          _isSwipeRight = false;
        } else {
          _isSwipeRight = true;
          _isSwipeLeft = false;
        }
      },
      onHorizontalDragEnd: (details) {
        if (_isSwipeLeft!) {
          if (widget.onSwipeLeft != null) {
            widget.onSwipeLeft!();
          }
        } else if (_isSwipeRight!) {
          if (widget.onSwipeRight != null) {
            widget.onSwipeRight!();
          }
        }
      },
      onVerticalDragStart: (details) {
        _verticalSwipeStartingOffset = details.localPosition;
      },
      onVerticalDragUpdate: (details) {
        if (_verticalSwipeStartingOffset!.dy > details.localPosition.dy) {
          _isSwipeUp = true;
          _isSwipeDown = false;
        } else {
          _isSwipeDown = true;
          _isSwipeUp = false;
        }
      },
      onVerticalDragEnd: (details) {
        if (_isSwipeUp! && widget.onSwipeUp != null) {
          widget.onSwipeUp!();
        } else if (_isSwipeDown! && widget.onSwipeDown != null) {
          widget.onSwipeDown!();
        }
      },
    )
        : (widget.onSwipeLeft != null || widget.onSwipeRight != null)
        ? GestureDetector(
      child: widget.child,
      onHorizontalDragStart: (details) {
        _horizontalSwipeStartingOffset = details.localPosition;
      },
      onHorizontalDragUpdate: (details) {
        if (_horizontalSwipeStartingOffset!.dx >
            details.localPosition.dx) {
          _isSwipeLeft = true;
          _isSwipeRight = false;
        } else {
          _isSwipeRight = true;
          _isSwipeLeft = false;
        }
      },
      onHorizontalDragEnd: (details) {
        if (_isSwipeLeft! && widget.onSwipeLeft != null) {
          widget.onSwipeLeft!();
        } else if (_isSwipeRight! && widget.onSwipeRight != null) {
          widget.onSwipeRight!();
        }
      },
    )
        : (widget.onSwipeDown != null || widget.onSwipeUp != null)
        ? GestureDetector(
      child: widget.child,
      onVerticalDragStart: (details) {
        _verticalSwipeStartingOffset = details.localPosition;
      },
      onVerticalDragUpdate: (details) {
        if (_verticalSwipeStartingOffset!.dy >
            details.localPosition.dy) {
          _isSwipeUp = true;
          _isSwipeDown = false;
        } else {
          _isSwipeDown = true;
          _isSwipeUp = false;
        }
      },
      onVerticalDragEnd: (details) {
        if (_isSwipeUp! && widget.onSwipeUp != null) {
          widget.onSwipeUp!();
        } else if (_isSwipeDown! && widget.onSwipeDown != null) {
          widget.onSwipeDown!();
        }
      },
    )
        : SizedBox.shrink();
  }
}

@Injectable()
class SwipeGestureRecognizerController {
  _SwipeGestureRecognizerState? swipeGestureRecognizer;
  gestureOff(){
    if(swipeGestureRecognizer != null){
      swipeGestureRecognizer!._gestureOff();
    }
  }
  gestureOn(){
    if(swipeGestureRecognizer != null){
      swipeGestureRecognizer!._gestureOn();
    }
  }
}