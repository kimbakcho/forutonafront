import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H001/TopH001NavExpendAniContent.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import '../../TopNavRouterType.dart';
import '../TopNavExpendComponent.dart';
import 'TopH001NavExpendDto.dart';

class TopH001NavExpendComponent extends StatefulWidget {
  final TopH001NavExpendDto topH001NavExpendDto;

  const TopH001NavExpendComponent({Key key, this.topH001NavExpendDto})
      : super(key: key);

  @override
  _TopH001NavExpendComponentState createState() =>
      _TopH001NavExpendComponentState();
}

class _TopH001NavExpendComponentState extends State<TopH001NavExpendComponent>
    with SingleTickerProviderStateMixin
    implements TopNavExpendComponent {
  AnimationController _controller;
  TopNavBtnMediator topNavBtnMediator;
  TopH001NavExpendAniContent _topH001NavExpendAniContent;
  _TopH001NavExpendComponentState() {
    topNavBtnMediator = sl();
    topNavBtnMediator.topNavExpendRegisterComponent(this);
    _topH001NavExpendAniContent = TopH001NavExpendAniContent();
  }

  @override
  void initState() {
    initAnimation();

    super.initState();
  }

  initAnimation() {
    _controller = AnimationController(
        vsync: this, duration: topNavBtnMediator.animationDuration);
    _controller.forward();
    _controller.addStatusListener(setListener);
  }

  void setListener(status) {
    if (status == AnimationStatus.dismissed) {
      _topH001NavExpendAniContent.collapsed();
    } else if (status == AnimationStatus.forward) {
      _topH001NavExpendAniContent.expended();
    }
  }

  Animation<double> getAnimation() {
    double smallSizeBtn = 80;
    return Tween<double>(
            begin: smallSizeBtn, end: widget.topH001NavExpendDto.btnWidthSize)
        .animate(_controller);
  }

  @override
  void dispose() {
    topNavBtnMediator.topNavExpendUnRegisterComponent(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return TopH001NavExpendAniComponent(
      animation: getAnimation(),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _topH001NavExpendAniContent,
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 36,
            height: 36,
            decoration:
                BoxDecoration(color: Color(0xffF6F6F6), shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.map,
                size: 17,
              ),
            ),
          )
        ],
      ),
      btnHeightSize: widget.topH001NavExpendDto.btnHeightSize,
    );
  }

  @override
  closeExpandNav() {
    _controller.reverse();
  }

  @override
  openExpandNav() {
    _controller.forward();
  }

  @override
  getTopNavRouterType() {
    return TopNavRouterType.H001;
  }
}




class TopH001NavExpendAniComponent extends StatelessWidget {
  final Animation<double> animation;
  final double btnHeightSize;
  final Widget child;

  const TopH001NavExpendAniComponent(
      {Key key, this.animation, this.btnHeightSize, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Positioned(
        right: 0,
        top: 0,
        width: animation.value,
        height: btnHeightSize,
        child: child,
      ),
      child: child,
    );
  }
}
