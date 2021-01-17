import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
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
    _aniController = AnimationController(duration: Duration(milliseconds: 500),vsync: this);
    _aniController.addListener(() {
      setState(() {

      });
    });

    animation = Tween<double>(begin: 0, end: 1).animate(_aniController);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IM001MainPageViewModel(sl(), context,_aniController),
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
                                    child: Text("장소, 주소를 검색"),
                                  ),
                                ),
                              )),
                              SizedBox(width: 16),
                            ])),
                        Expanded(
                            child: Container(
                          child: GoogleMap(
                            initialCameraPosition: model.initCameraPosition,
                            onCameraMove: model.onCameraMove,
                            onMapCreated: model.onCreateMap,
                            onCameraIdle: model.onCameraIdle,
                          ),
                          margin: EdgeInsets.only(bottom: 71),
                        ))
                      ],
                    ),
                    Container(
                      color: Color(0xff2F3035).withOpacity(animation.value.clamp(0, 0.7)),
                    )
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

  IM001MainPageViewModel(this._geoLocationUtilForeGroundUseCase, this.context,this.aniController) {
    var currentWithLastPositionInMemory =
        _geoLocationUtilForeGroundUseCase.getCurrentWithLastPositionInMemory();
    initCameraPosition = new CameraPosition(
        zoom: 14.56,
        target: LatLng(currentWithLastPositionInMemory.latitude,
            currentWithLastPositionInMemory.longitude));
    _solidController = SolidController();

    _im001bottomSheetHeaderController = IM001BottomSheetHeaderController();

    bottomWidget = SolidBottomSheet(
      maxHeight: 500,
      draggableBody: false,
      controller: _solidController,
      onShow: (){
        aniController.forward();
        _im001bottomSheetHeaderController.changeHeaderMode(IM001BottomSheetHeaderMode.show);
      },
      onHide: (){
        aniController.reverse();
        _im001bottomSheetHeaderController.changeHeaderMode(IM001BottomSheetHeaderMode.hide);
      },
      headerBar: IM001BottomSheetHeader(
        onNextBtnTap: (){
          _solidController.show();
        },
        displayAddress: "TEST",
        im001bottomSheetHeaderController: _im001bottomSheetHeaderController,
      ),
      body: IM001BottomSheetBody(
        initAddress: "TEST",
        onChangeAddress: (value){
          _im001bottomSheetHeaderController.changeDisplayAddress(value);
        },
      ),
    );
  }

  getBottomSheet(){
    return bottomWidget;
  }


  void onCreateMap(GoogleMapController controller) async {
    _googleMapController.complete(controller);
  }

  void onCameraIdle() async {}

  void onCameraMove(CameraPosition position) {
    currentPosition = position;
  }
}
