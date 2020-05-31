import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style1/Widget/IssueBallStyle1MarkerWidget.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style1/Widget/QuestBallStyle1MarkerWidget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3Widget.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'ICodeMainPageViewModel.dart';

class ICodeMainPage extends StatefulWidget {
  @override
  _ICodeMainPageState createState() => _ICodeMainPageState();
}

class _ICodeMainPageState extends State<ICodeMainPage> with WidgetsBindingObserver {
  AppLifecycleState _lastLifecycleState;
  UniqueKey googleMapKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)   {
    googleMapKey = UniqueKey();
    setState(()  {
      _lastLifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white.withOpacity(0.6),
        statusBarIconBrightness: Brightness.dark));
    return ChangeNotifierProvider(
        create: (_) => ICodeMainPageViewModel(context),
        child: Consumer<ICodeMainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    key: model.mapContainerGlobalKey,
                    child: Stack(children: <Widget>[
                      //해당 부분 마커에서 그림 파일에 캐쉬에 없어 초기에 못그려줘 일부러 여기서
                      //그려줌 캐슁해주기 위해서 사용함.
                      Positioned(
                          top: -200,
                          left: -200,
                          width: 200,
                          height: 200,
                          child: Column(
                            children: <Widget>[
                              QuestBallStyle1MarkerWidget.selectBall(),
                              IssueBallStyle1MarkerWidget.selectBall()
                            ],
                          )),
                      GoogleMap(
                        key: googleMapKey,
                        initialCameraPosition: model.initCameraPosition,
                        onMapCreated: model.onCreateMap,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        indoorViewEnabled: true,
                        onCameraMove: model.onMoveMap,
                        onCameraMoveStarted: model.onMoveStartMap,
                        onCameraIdle: model.onMapIdle,
                        markers: model.markers,
                        zoomControlsEnabled: false,
                      ),

                      Positioned(
                        top: MediaQuery.of(context).padding.top+16,
                        left: 0,
                        width: MediaQuery.of(context).size.width,
                        child: textMapSerachBar(model,context),
                      ),
                      Positioned(
                          top: 108,
                          right: 16,
                          child: myLocationButton(model)),
                      Positioned(
                          top: 176,
                          right: 16,
                          child: ballReFreshButton(model)),
                      Positioned(
                        bottom: 0,
                        width: MediaQuery.of(context).size.width,
                        height: 52,
                        child: BottomNavigation(),
                      ),
                      Positioned(
                        bottom: 69,
                        left: 0,
                        child: bottomBallListUp(model,context),
                      ),
                    ]))),
            model.getIsLoading() ? CommonLoadingComponent() : Container()
          ]

          );
        }));
  }

  Container bottomBallListUp(ICodeMainPageViewModel model,BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: model.bottomPageController,
          onPageChanged: model.onBallListSelectChanged,
          itemCount: model.listUpBalls.length,
          itemBuilder: (context, index) {
            return model.listUpBalls[index].ballStyle3Widget;
          }),
    );
  }

  AnimatedContainer ballReFreshButton(ICodeMainPageViewModel model) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: model.reFreshBtnActive ? Curves.bounceOut : Curves.bounceIn,
        height: model.reFreshBtnActive ? 52.00 : 0,
        width: model.reFreshBtnActive ? 52.00 : 0,
        child: FlatButton(
          padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
          onPressed: () {
            model.onRefreshBall();
          },
          child: Icon(
            ForutonaIcon.repost,
            size: model.reFreshBtnActive ? 10 : 0,
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 12.00),
              color: Color(0xff455b63).withOpacity(0.10),
              blurRadius: 16,
            )
          ],
          borderRadius: BorderRadius.circular(12.00),
        ));
  }

  Container myLocationButton(ICodeMainPageViewModel model) {
    return Container(
      height: 52.00,
      width: 52.00,
      child: FlatButton(
        onPressed: model.onMyLocation,
        child: Icon(Icons.my_location, color: Color(0xff454F63), size: 18),
      ),
      decoration: BoxDecoration(
        color: Color(0xffffffff).withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 12.00),
            color: Color(0xff455b63).withOpacity(0.10),
            blurRadius: 16,
          ),
        ],
        borderRadius: BorderRadius.circular(12.00),
      ),
    );
  }

  Stack textMapSerachBar(ICodeMainPageViewModel model,BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            height: 52.00,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: FlatButton(
              padding: EdgeInsets.fromLTRB(16, 0, 35, 0),
              child: Container(
                alignment: Alignment.center,
                child: Text(model.currentAddress,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff454f63),
                    )),
              ),
              onPressed:model.onPlaceSearchTap,
            ),
            decoration: BoxDecoration(
              color: Color(0xffffffff).withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff455b63).withOpacity(0.2),
                  blurRadius: 6,
                )
              ],
              borderRadius: BorderRadius.circular(12.00),
            )),
        Positioned(
          right: 32,
          top: 16,
          child: Icon(ForutonaIcon.search),
        )
      ],
    );
  }
}
