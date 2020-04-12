import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/HCodePage/H007/H007MainPageViewModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class H007MainPage extends StatelessWidget {
  Position initPosition;
  String address;

  H007MainPage(this.initPosition, this.address);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H007MainPageViewModel(initPosition, address, context),
        child: Consumer<H007MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Stack(children: <Widget>[
              GoogleMap(
                initialCameraPosition: model.initCameraPosition,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: model.onMapCreate,
                onCameraMove: model.onCameraMove,
                onCameraIdle: model.onMapIdle,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: topGradiantEffect(),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 2.h,
                left: 16.w,
                child: topAddressBar(model),
              ),
              Positioned(
                top: 96.h,
                right: 16.w,
                child: myLocationBtn(model),
              ),
              Center(
                child: Icon(
                  ForutonaIcon.anchor,
                  color: Color(0xff454F63),
                  size: 22.sp,
                ),
              ),
              Positioned(
                bottom: 24.h,
                child: bottomSerarchBtn(model),
              )
            ]))
          ]);
        }));
  }

  Container bottomSerarchBtn(H007MainPageViewModel model) {
    return Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
        height: 52.00.h,
        width: 328.00.w,
        child: FlatButton(
          onPressed: () {
            model.onMapBallSearch(model.currentCameraPosition.target);
          },
          child: Text("이 근처의 볼을 검색합니다.",
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Color(0xfff9f9f9),
              )),
          padding: EdgeInsets.all(0),
        ),
        decoration: BoxDecoration(
            color: Color(0xff3497fd),
            border: Border.all(
              width: 1.00.w,
              color: Color(0xff4f72ff),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00.w),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              )
            ],
            borderRadius: BorderRadius.circular(12.00.w)));
  }

  Container myLocationBtn(H007MainPageViewModel model) {
    return Container(
        height: 52.00.h,
        width: 52.00.w,
        child: FlatButton(
          onPressed: () {
            model.onMyLocation();
          },
          child: Icon(Icons.my_location),
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
        ));
  }

  Container topAddressBar(H007MainPageViewModel model) {
    return Container(
        child: Container(
            height: 52.00.h,
            width: 328.00.w,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                  height: 24.h,
                  width: 24.w,
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: model.onBackBtnClick,
                      child: Icon(ForutonaIcon.searchbackbtn)),
                ),
                Container(
                  height: 24.00.h,
                  width: 1.00.w,
                  decoration: BoxDecoration(
                    color: Color(0xfff4f4f6),
                    borderRadius: BorderRadius.circular(1.00.w),
                  ),
                ),
                Container(
                  width: 241.w,
                  margin: EdgeInsets.fromLTRB(16.w, 0, 0.w, 0),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: model.onPlaceSearchTap,
                    child: Text(model.address,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 14.sp,
                          color: Color(0xff454f63),
                        )),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 12.00.w),
                  color: Color(0xff455b63).withOpacity(0.08),
                  blurRadius: 16.w,
                ),
              ],
              borderRadius: BorderRadius.circular(12.00.w),
            )));
  }

  IgnorePointer topGradiantEffect() {
    return IgnorePointer(
        child: Container(
            height: 165.h,
            width: 360.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 1],
                  colors: [Colors.white, Colors.white.withOpacity(0)]),
            )));
  }
}
