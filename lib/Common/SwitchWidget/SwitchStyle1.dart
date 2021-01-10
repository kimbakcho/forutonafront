import 'package:flutter/material.dart';



class SwitchStyle1 extends StatefulWidget {
  final bool initValue;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor = Colors.grey;
  final SwitchStyle1Controller switchStyle1Controller;

  const SwitchStyle1({
    Key key,
    this.initValue,
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

  bool value;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 60),vsync: this);
    _circleAnimation = AlignmentTween(
            begin: widget.initValue ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.initValue ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
    widget.switchStyle1Controller._switchStyle1State =  this;
    value = widget.initValue;
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
                value = !value;
                widget.onChanged(value);
              },
              child: Container(
                height: 25.00,
                width: 56.00,
                alignment: _circleAnimation.value,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                  child: Container(
                    height: 21.00,
                    width: 21.00,
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
                          blurRadius: 6,
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

class SwitchStyle1Controller {

  _SwitchStyle1State _switchStyle1State;

  SwitchStyle1Controller();

  check() {
    if(_switchStyle1State != null){
      _switchStyle1State._animationController.forward();
    }

  }

  unCheck(){
    if(_switchStyle1State != null){
      _switchStyle1State._animationController.reverse();
    }
  }

  bool get isCheck{
    return _switchStyle1State.value;
  }

}
