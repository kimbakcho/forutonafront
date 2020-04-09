import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3Support.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'ICodeMainPageViewModel.dart';

class ICodeMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var statueBar = SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white.withOpacity(0.6),
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(statueBar);
    return ChangeNotifierProvider(
        create: (_) => ICodeMainPageViewModel(context),
        child: Consumer<ICodeMainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    key: model.mapContainerGlobalKey,
                    child: Stack(children: <Widget>[
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: model.initCameraPosition,
                        onMapCreated: model.onCreateMap,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        indoorViewEnabled: true,
                        onCameraMove: model.onMoveMap,
                        markers: model.markers,
                      ),
                      Positioned(
                        top: 40.h,
                        left: 16.w,
                        child: textMapSerachBar(model),
                      ),
                      Positioned(
                          top: 108.h,
                          right: 16.w,
                          child: myLocationButton(model)),
                      Positioned(
                          top: 176.h,
                          right: 16.w,
                          child: ballReFreshButton(model)),
                      Positioned(
                        bottom: 0,
                        width: 360.w,
                        height: 52.h,
                        child: BottomNavigation(),
                      ),
                      Positioned(
                        bottom: 69.h,
                        left: 0.h,
                        child: bottomBallListUp(model),
                      )
                    ])..children.addAll(model.ballMakerWidget)))
          ]);
        }));
  }

  Container bottomBallListUp(ICodeMainPageViewModel model) {
    return Container(
      height: 90.h,
      width: 360.w,
      child: PageView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: model.bottomPageController,
          itemCount: model.listUpBalls.length,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.only(right: 7.w),
                child: BallStyle3Support.selectBallWidget(
                    model.listUpBalls[index]));
          }),
    );
  }

  Container ballReFreshButton(ICodeMainPageViewModel model) {
    return Container(
        height: 52.00.h,
        width: 52.00.w,
        child: FlatButton(
          padding: EdgeInsets.fromLTRB(0, 0, 8.w, 0),
          onPressed: () {
            model.onRefreshBall();
          },
          child: Icon(
            ForutonaIcon.repost,
            size: 10.sp,
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 12.00.w),
              color: Color(0xff455b63).withOpacity(0.10),
              blurRadius: 16.w,
            )
          ],
          borderRadius: BorderRadius.circular(12.00.w),
        ));
  }

  Container myLocationButton(ICodeMainPageViewModel model) {
    return Container(
      height: 52.00.h,
      width: 52.00.w,
      child: FlatButton(
        onPressed: model.onMyLocation,
        child: Icon(Icons.my_location, color: Color(0xff454F63), size: 18.sp),
      ),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 12.00.w),
            color: Color(0xff455b63).withOpacity(0.10),
            blurRadius: 16.w,
          ),
        ],
        borderRadius: BorderRadius.circular(12.00.w),
      ),
    );
  }

  Stack textMapSerachBar(ICodeMainPageViewModel model) {
    return Stack(
      children: <Widget>[
        Container(
            height: 52.00.h,
            width: 328.00.w,
            child: FlatButton(
              child: Text(model.currentAddress,
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: Color(0xff454f63),
                  )),
              onPressed: () {},
            ),
            decoration: BoxDecoration(
              color: Color(0xffffffff).withOpacity(0.90),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00.w),
                  color: Color(0xff455b63).withOpacity(0.45),
                  blurRadius: 6.w,
                )
              ],
              borderRadius: BorderRadius.circular(12.00.w),
            )),
        Positioned(
          right: 14.w,
          top: 16.h,
          child: Icon(ForutonaIcon.search),
        )
      ],
    );
  }
}
