import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPageViewModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ID001MainPage extends StatelessWidget {
  final FBallResDto _fBallResDto;

  ID001MainPage(this._fBallResDto);

  @override
  Widget build(BuildContext context) {
    var statueBar = SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white.withOpacity(0.6),
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(statueBar);
    return ChangeNotifierProvider(
        create: (_) => ID001MainPageViewModel(context, _fBallResDto),
        child: Consumer<ID001MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                                width: 360.w,
                                child: ListView(
                                  controller: model.mainScrollController,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(0),
                                    children: <Widget>[
                                      googleMapBar(model)]))),
                        Positioned(
                            top: MediaQuery.of(context).padding.top,
                            left: 0,
                            child: topHeaderBar())
                      ],
                    )))
          ]);
        }));
  }

  Container googleMapBar(ID001MainPageViewModel model) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: RepaintBoundary(
                  key: model.makerAnimationKey,
                  child: Container(
                    width: 240.w,
                    height: 240.h,
                    child: FlareActor(
                      "assets/Rive/radar.flr",
                      alignment: Alignment.center,
                      animation: "animating",
                      fit: BoxFit.contain,
                    ),
                  ))),
          GoogleMap(
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                    () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            initialCameraPosition: model.initialCameraPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: model.markers,
          )
        ],
      ),
      width: 360.w,
      height: 323.h,
    );
  }

  Container topHeaderBar() {
    return Container(
      height: 56.h,
      width: 360.w,
      child: Row(children: <Widget>[
        Container(
          width: 32.w,
          height: 32.h,
          padding: EdgeInsets.only(left: 8.w),
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 18.sp,
              )),
          alignment: Alignment.center,
        ),
        Spacer(),
        Container(
          width: 32.w,
          height: 32.h,
          padding: EdgeInsets.only(left: 8.w),
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(
                ForutonaIcon.share,
                color: Colors.black,
                size: 18.sp,
              )),
          alignment: Alignment.center,
        ),
        Container(
          width: 32.w,
          height: 32.h,
          margin: EdgeInsets.only(right: 16.w),
          padding: EdgeInsets.only(left: 8.w),
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(
                ForutonaIcon.setting,
                color: Colors.black,
                size: 18.sp,
              )),
          alignment: Alignment.center,
        )
      ]),
      decoration: BoxDecoration(color: Color(0xffffffff).withOpacity(0.6)),
    );
  }
}
