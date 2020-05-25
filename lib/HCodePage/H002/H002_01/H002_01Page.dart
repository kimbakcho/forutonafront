import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/HCodePage/H002/H002_01/H002_01PageViewModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types, must_be_immutable
class H002_01Page extends StatelessWidget {
  Position initPosition;
  String address;

  H002_01Page(this.initPosition, this.address) {
    var statueBar = SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white.withOpacity(0),
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(statueBar);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H002_01PageViewModel(initPosition, address, context),
        child: Consumer<H002_01PageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Stack(children: <Widget>[
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: model.initCameraPosition,
                onMapCreated: model.onCreateMap,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                indoorViewEnabled: true,
                onCameraMove: model.onMoveMap,
                onCameraMoveStarted: model.onMoveStartMap,
                onCameraIdle: model.onMapIdle,
                zoomControlsEnabled: false,
              ),
              Center(child: UpDownPin(model)),
              Center(
                child: UpDownPinBottm(),
              ),
              Positioned(
                  top: 28,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  child: topAddressBar(model, context)),
              Positioned(
                top: 96,
                right: 16,
                child: myLocationBtn(model),
              ),
              Positioned(
                bottom: 24,
                width: MediaQuery.of(context).size.width,
                child: bottomAddBallBtn(model),
              ),
              model.getIsLoading() ? CommonLoadingComponent() : Container()
            ]))
          ]);
        }));
  }

  Container UpDownPinBottm() {
    return Container(
      height: 3,
      width: 3,
      margin: EdgeInsets.only(bottom: 3),
      color: Colors.grey,
    );
  }

  AnimatedContainer UpDownPin(H002_01PageViewModel model) {
    return AnimatedContainer(
        width: 39,
        height: 56,
        duration: Duration(milliseconds: 300),
        margin: model.isBallPinUp
            ? EdgeInsets.only(bottom: 80)
            : EdgeInsets.only(bottom: 56),
        curve: Curves.linear,
        child: Stack(children: <Widget>[
          Container(
            width: 39,
            height: 56,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/MainImage/IssueBallPin.png"),
                    fit: BoxFit.fitHeight)),
          )
        ]));
  }

  Container bottomAddBallBtn(H002_01PageViewModel model) {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        height: 52.00,
        child: FlatButton(
          onPressed: () {
            model.onMapBallAdd(
                model.currentCameraPosition.target, model.address);
          },
          child: Text("이슈볼을 설치합니다.",
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xfff9f9f9),
              )),
          padding: EdgeInsets.all(0),
        ),
        decoration: BoxDecoration(
            color: Color(0xff3497fd),
            border: Border.all(
              width: 1.00,
              color: Color(0xff4f72ff),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              )
            ],
            borderRadius: BorderRadius.circular(12.00)));
  }

  Container myLocationBtn(H002_01PageViewModel model) {
    return Container(
        height: 52.00,
        width: 52.00,
        child: FlatButton(
          padding: EdgeInsets.only(right: 1),
          onPressed: () {
            model.onMyLocation();
          },
          child: Icon(Icons.my_location),
        ),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 12.00),
              color: Color(0xff455b63).withOpacity(0.10),
              blurRadius: 16,
            ),
          ],
          borderRadius: BorderRadius.circular(12.00),
        ));
  }

  Container topAddressBar(H002_01PageViewModel model, BuildContext context) {
    return Container(
        child: Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            height: 52.00,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  height: 24,
                  width: 24,
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: model.onBackBtnClick,
                      child: Icon(ForutonaIcon.searchbackbtn)),
                ),
                Container(
                  height: 24.00,
                  width: 1.00,
                  decoration: BoxDecoration(
                    color: Color(0xfff4f4f6),
                    borderRadius: BorderRadius.circular(1.00),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    onPressed: model.onPlaceSearchTap,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(model.address,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14,
                            color: Color(0xff454f63),
                          )),
                    ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 12.00),
                  color: Color(0xff455b63).withOpacity(0.08),
                  blurRadius: 16,
                ),
              ],
              borderRadius: BorderRadius.circular(12.00),
            )));
  }
}
