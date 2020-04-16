import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchStyle1Controller {
  Function(bool) moveSwitch;
}

class SwitchStyle1 extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor = Colors.grey;
  final SwitchStyle1Controller switchStyle1Controller;

  const SwitchStyle1({
    Key key,
    this.value,
    this.onChanged,
    this.activeColor,
    this.switchStyle1Controller
  }) : super(key: key);

  @override
  _SwitchStyle1State createState() => _SwitchStyle1State();
}

class _SwitchStyle1State extends State<SwitchStyle1>
    with SingleTickerProviderStateMixin {
  Animation _circleAnimation;
  AnimationController _animationController;



  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
    widget.switchStyle1Controller.moveSwitch =  moveSwitch;
  }

  moveSwitch(bool value){
    if(value){
      _animationController.forward();
    }else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return GestureDetector(
              onTap: () {
                if (_animationController.isCompleted) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
                widget.value == false
                    ? widget.onChanged(true)
                    : widget.onChanged(false);
              },
              child: Container(
                height: 25.00.h,
                width: 56.00.w,
                alignment: _circleAnimation.value,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                  child: Container(
                    height: 21.00.h,
                    width: 21.00.w,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      border: Border.all(
                        width: 1.00,
                        color: Color(0xffffffff),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                          blurRadius: 6.w,
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: _circleAnimation.value == Alignment.centerLeft
                      ? widget.inactiveColor
                      : widget.activeColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 12.00),
                      color: Color(0xff455b63).withOpacity(0.08),
                      blurRadius: 16,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(14.00),
                ),
              ));
        });
  }
}
