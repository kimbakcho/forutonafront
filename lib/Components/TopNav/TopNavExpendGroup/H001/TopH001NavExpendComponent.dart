import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';

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

  _TopH001NavExpendComponentState() {
    topNavBtnMediator = sl();
    topNavBtnMediator.topNavExpendRegisterComponent(this);
  }

  @override
  void initState() {
    initAnimation();

    super.initState();
  }

  initAnimation() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _controller.forward();
    _controller.addStatusListener(setListener);
  }

  void setListener(status) {
    if (status == AnimationStatus.dismissed) {
      setState(() {
        widget.topH001NavExpendDto.addressText =
            widget.topH001NavExpendDto.shortAddressText;
      });
    } else if (status == AnimationStatus.forward) {
      setState(() {
        widget.topH001NavExpendDto.addressText =
            widget.topH001NavExpendDto.longAddressText;
      });
    }
  }

  Animation<double> getAnimation() {
    return Tween<double>(
            begin: 80, end: widget.topH001NavExpendDto.btnWidthSize)
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
            child: TopH001NavExpendAniContent(
                topH001NavExpendDto: widget.topH001NavExpendDto),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
              shape: BoxShape.circle
            ),

            child: IconButton(
              onPressed: (){

              },
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.map,size: 17,),
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

class TopH001NavExpendAniContent extends StatelessWidget {
  final TopH001NavExpendDto topH001NavExpendDto;

  const TopH001NavExpendAniContent({Key key, this.topH001NavExpendDto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20.0)) ),
                padding: EdgeInsets.all(0),
                onPressed: () {},
                child: Text(
                  topH001NavExpendDto.addressText,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff454f63),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Color(0xffF6F6F6),
              )),
        )
      ],
    );
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
