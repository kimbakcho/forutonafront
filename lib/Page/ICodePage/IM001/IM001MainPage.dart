import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import 'package:forutonafront/Components/BackButton/BorderCircleBackButton.dart';
import 'package:forutonafront/Components/SolidBottomSheet/src/solidBottomSheet.dart';
import 'package:forutonafront/Components/SolidBottomSheet/src/solidController.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001BottomSheetBody.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001BottomSheetHeader.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class IM001MainPage extends StatefulWidget {
  @override
  _IM001MainPageState createState() => _IM001MainPageState();
}

class _IM001MainPageState extends State<IM001MainPage>
    with SingleTickerProviderStateMixin {
  AnimationController _aniController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _aniController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _aniController.addListener(() {
      setState(() {});
    });

    animation = Tween<double>(begin: 0, end: 1).animate(_aniController);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            IM001MainPageViewModel(sl(), context, _aniController, sl()),
        child: Consumer<IM001MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              bottomSheet: model.getBottomSheet(),
              body: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Stack(children: [
                    Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(children: [
                              SizedBox(width: 16),
                              Material(
                                color: Color(0xffF6F6F6),
                                shape: CircleBorder(),
                                child: InkWell(
                                  customBorder: CircleBorder(),
                                  onTap: () {},
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                  child: Material(
                                color: Color(0xffF6F6F6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                child: InkWell(
                                  customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  onTap: () {},
                                  child: Container(
                                    height: 36,
                                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(model.headBarAddress),
                                  ),
                                ),
                              )),
                              SizedBox(width: 16),
                            ])),
                        Expanded(
                            child: Container(
                          child: Stack(
                            children: [
                              GoogleMap(
                                initialCameraPosition: model.initCameraPosition,
                                onCameraMove: model.onCameraMove,
                                onMapCreated: model.onCreateMap,
                                onCameraIdle: model.onCameraIdle,
                              ),
                              Center(
                                  child: IgnorePointer(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/MarkesImages/issueballicon2.png")))))),
                              Positioned(
                                  right: 16,
                                  top: 16,
                                  child: Material(
                                    color: Colors.white,
                                    shape: CircleBorder(),
                                    child: InkWell(
                                      customBorder: CircleBorder(),
                                      onTap: () {
                                        model.moveToMyPosition();
                                      },
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        child: Icon(
                                          Icons.my_location,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: 71),
                        ))
                      ],
                    ),
                    model.isBottomOpened
                        ? Container(
                            color: Color(0xff2F3035)
                                .withOpacity(animation.value.clamp(0, 0.7)),
                          )
                        : Container(),
                    Positioned(
                        top: (60 * animation.value) - 60,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              width: 36,
                              height: 36,
                              child: Material(
                                color: Color(0xffF6F6F6),
                                shape: CircleBorder(),
                                child: InkWell(
                                  onTap: () {
                                    model._solidController.hide();
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Color(0xff454F63), size: 20),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 16),
                              child: FlatButton(
                                disabledTextColor: Color(0xffD4D4D4),
                                disabledColor: Color(0xffF6F6F6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12)),
                                      side: model.isCanComplete ? BorderSide(color: Colors.black,width: 1): BorderSide.none
                                  ),
                                  color: Colors.white,
                                  onPressed: model.isCanComplete ? () {}: null,
                                  child: Text("완료")),
                            )
                          ],
                        ))
                  ])));
        }));
  }
}

class IM001MainPageViewModel extends ChangeNotifier {
  CameraPosition initCameraPosition;
  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCase;
  CameraPosition currentPosition;
  Completer<GoogleMapController> _googleMapController = Completer();

  bool isBallPosition = true;

  final BuildContext context;

  SolidController _solidController;

  Widget bottomWidget;

  AnimationController aniController;

  IM001BottomSheetHeaderController _im001bottomSheetHeaderController;

  MapBallMarkerFactory _mapBallMarkerFactory;

  String headBarAddress;

  IM001BottomSheetBodyController _im001bottomSheetBodyController;

  IM001MainPageViewModel(this._geoLocationUtilForeGroundUseCase, this.context,
      this.aniController, this._mapBallMarkerFactory) {
    headBarAddress = '로딩중';

    _im001bottomSheetBodyController = IM001BottomSheetBodyController();
    var currentWithLastPositionInMemory =
        _geoLocationUtilForeGroundUseCase.getCurrentWithLastPositionInMemory();
    initCameraPosition = new CameraPosition(
        zoom: 14.56,
        target: LatLng(currentWithLastPositionInMemory.latitude,
            currentWithLastPositionInMemory.longitude));
    _solidController = SolidController();

    _im001bottomSheetHeaderController = IM001BottomSheetHeaderController();

    bottomWidget = SolidBottomSheet(
      maxHeight: MediaQuery.of(context).size.height - 150,
      draggableBody: false,
      controller: _solidController,
      bodyColor: Colors.white,
      onShow: () {
        aniController.forward();
        _im001bottomSheetHeaderController
            .changeHeaderMode(IM001BottomSheetHeaderMode.show);
      },
      onHide: () {
        aniController.reverse();
        _im001bottomSheetHeaderController
            .changeHeaderMode(IM001BottomSheetHeaderMode.hide);
      },
      headerBar: IM001BottomSheetHeader(
        onNextBtnTap: () {
          _solidController.show();
        },
        displayAddress: "로딩중",
        im001bottomSheetHeaderController: _im001bottomSheetHeaderController,
      ),
      body: IM001BottomSheetBody(
        initAddress: "로딩중",
        im001bottomSheetBodyController: _im001bottomSheetBodyController,
        onChangeAddress: (value) {
          _im001bottomSheetHeaderController.changeDisplayAddress(value);
        },
      ),
    );
  }

  get isCanComplete{
    return false;
  }

  getBottomSheet() {
    return bottomWidget;
  }

  get isBottomOpened {
    return _solidController.isOpened;
  }

  void onCreateMap(GoogleMapController controller) async {
    _googleMapController.complete(controller);
    var position = await moveToMyPosition();

    String address =
        await _geoLocationUtilForeGroundUseCase.getPositionAddress(position);
    _im001bottomSheetBodyController.changeDisplayAddress(address);
    _im001bottomSheetHeaderController.changeDisplayAddress(address);

    headBarAddress = address;

    notifyListeners();
  }

  void onCameraIdle() async {
    if (currentPosition != null) {
      var position2 = Position(
          latitude: currentPosition.target.latitude,
          longitude: currentPosition.target.longitude);
      String address =
          await _geoLocationUtilForeGroundUseCase.getPositionAddress(position2);
      _im001bottomSheetBodyController.changeDisplayAddress(address);
      notifyListeners();
    }
  }

  moveToMyPosition() async {
    var position =
        await _geoLocationUtilForeGroundUseCase.getCurrentWithLastPosition();
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 14.5)));
    return position;
  }

  void onCameraMove(CameraPosition position) async {
    currentPosition = position;
  }
}
