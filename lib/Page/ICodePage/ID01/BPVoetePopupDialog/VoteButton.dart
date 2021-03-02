import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class VoteButton extends StatefulWidget {
  final Color backGroundColor;
  final Color borderLineColor;
  final IconData mainIcon;
  final String labelText;
  final Color labelColor;
  final Function onClick;
  final Color mainIconColor;
  final VoteButtonViewController voteButtonViewController;
  final bool Function() isCanPlus;

  const VoteButton(
      {Key key,
      this.backGroundColor,
      this.borderLineColor,
      this.mainIcon,
      this.labelText,
      this.labelColor,
      this.onClick,
      this.mainIconColor, this.voteButtonViewController, this.isCanPlus})
      : super(key: key);

  @override
  _VoteButtonState createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 500);

  AnimationController controller;

  Animation<double> animation;

  _VoteButtonState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => VoteButtonViewModel(widget.voteButtonViewController,widget.isCanPlus),
        child: Consumer<VoteButtonViewModel>(builder: (_, model, child) {
          return Container(
              child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                            child: Column(
                          children: [
                            Material(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              color: widget.backGroundColor.withOpacity(colorOpacityValue()),
                              child: InkWell(
                                  onTap: () {
                                    model.setNextPoint();
                                    controller.forward().whenComplete(() {
                                      model.plusCurrentPoint();
                                      controller.reset();
                                    });
                                    if (widget.onClick != null) {
                                      widget.onClick();
                                    }
                                  },
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      height: 60,
                                      width: 60,
                                      child: Center(
                                        child: Icon(
                                          widget.mainIcon,
                                          color: widget.mainIconColor.withOpacity(colorOpacityValue()),
                                        ),
                                      ))),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                                child: Center(
                                    child: Text(widget.labelText,
                                        style: GoogleFonts.notoSans(
                                          fontSize: 12,
                                          color: widget.labelColor.withOpacity(colorOpacityValue()),
                                          fontWeight: FontWeight.w500,
                                        )))),
                          ],
                        )),
                        Positioned(
                          right: -15,
                            child: Container(
                          child: Text('${model.currentPoint}',
                            style: GoogleFonts.notoSans(
                              fontSize: 15,
                              color: widget.labelColor,
                              fontWeight: FontWeight.w500,
                              height: 1.3333333333333333,
                            ),
                          ),
                        )),
                        animation.status == AnimationStatus.forward ?
                        Positioned(
                            right: -15,
                            top: 18-(18*processAniValue()),
                            child: Text(
                          '${model.nextPoint}',
                              style: GoogleFonts.notoSans(
                                fontSize: 15,
                                color: widget.labelColor.withOpacity(colorOpacityValue()),
                                fontWeight: FontWeight.w500,
                                height: 1.3333333333333333,
                              ),

                        )): Container(width: 0,height: 0,)
                      ],
                    );
                  }));
        }));
  }

  double colorOpacityValue(){
    return max(0.3,1-sin(radians(animation.value)));
  }

  double processAniValue(){
    return animation.value/180.0;
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: _duration);
    animation = controller.drive(
      Tween<double>(begin: 0.0, end: 180.0),
    );

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class VoteButtonViewModel extends ChangeNotifier {

  final VoteButtonViewController _voteButtonViewController;

  int currentPoint = 0;

  int nextPoint = 0;

  final bool Function() isCanPlus;

  VoteButtonViewModel(this._voteButtonViewController, this.isCanPlus){
    if(_voteButtonViewController != null){
      _voteButtonViewController._viewModel = this;
    }
  }

  plusCurrentPoint(){
    currentPoint = nextPoint;
    if(_voteButtonViewController != null && _voteButtonViewController.onCurrentPointChange != null){
      _voteButtonViewController.onCurrentPointChange(currentPoint);
    }
  }

  setNextPoint(){
    if(isCanPlus()){
      nextPoint = currentPoint + 1;
    }

  }

}

class VoteButtonViewController {

  VoteButtonViewModel _viewModel;

  final Function(int) onCurrentPointChange;

  VoteButtonViewController({this.onCurrentPointChange});

  int getCurrentPoint(){
    if(_viewModel == null){
      return 0;
    }
    return _viewModel.currentPoint;
  }

}
