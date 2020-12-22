import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'IMB001WidgetPart/IMB001TopAppBar.dart';

class IMB001FullScreenMap extends StatelessWidget {
  final Position initPosition;
  final String ballUuid;
  final String initAddress;

  IMB001FullScreenMap({this.initPosition, this.ballUuid, this.initAddress});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IMB001FullScreenMapViewModel(
            initPosition: initPosition,
            ballUuid: ballUuid,
            geoLocationUtilForeGroundUseCase: sl(),
            mapMakerDescriptorContainer: sl(),
            selectBallUseCaseInputPort: sl(),
            mapBallMarkerFactory: sl()),
        child: Consumer<IMB001FullScreenMapViewModel>(builder: (_, model, __) {
          return Scaffold(
              body: Container(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(children: <Widget>[
                    IMB001TopAppBar(),
                    Expanded(
                        child: Container(
                            child: Stack(children: <Widget>[
                      GoogleMap(
                        onMapCreated: model.onCreateMap,
                        onCameraMove: model.onCameraMove,
                        onCameraIdle: model.onCameraIdle,
                        initialCameraPosition: model.initCameraPosition,
                        markers: model.markers,
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: InkWell(
                          onTap: () {
                            model.mapMoveBallPosition();
                          },
                          child: Container(
                              width: 52,
                              height: 52,
                              child: Icon(
                                ForutonaIcon.gps,
                                color: Color(0xff454F63),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: const Color(0xccffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x15455b63),
                                      offset: Offset(0, 12),
                                      blurRadius: 16,
                                    )
                                  ])),
                        ),
                      )
                    ]))),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 77,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          model.mapMoveBallPosition();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              initAddress,
                              style: GoogleFonts.notoSans(
                                fontSize: 12,
                                color: const Color(0xff454f63),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "이슈볼이 설치된 위치로 이동합니다.",
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: model.isBallPosition
                                    ? const Color(0xffb1b1b1)
                                    : const Color(0xff007eff),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ])));
        }));
  }
}

class IMB001FullScreenMapViewModel extends ChangeNotifier {
  final Position initPosition;
  CameraPosition initCameraPosition;
  final MapBallMarkerFactory _mapBallMarkerFactory;
  final MapMakerDescriptorContainer _mapMakerDescriptorContainer;
  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;
  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCase;
  final String ballUuid;
  Completer<GoogleMapController> _googleMapController = Completer();
  Set<Marker> markers;
  Position userPosition;
  bool isBallPosition = true;
  CameraPosition currentPosition;

  IMB001FullScreenMapViewModel(
      {this.initPosition,
      this.ballUuid,
      MapBallMarkerFactory mapBallMarkerFactory,
      MapMakerDescriptorContainer mapMakerDescriptorContainer,
      SelectBallUseCaseInputPort selectBallUseCaseInputPort,
      GeoLocationUtilForeGroundUseCaseInputPort
          geoLocationUtilForeGroundUseCase})
      : _mapBallMarkerFactory = mapBallMarkerFactory,
        _mapMakerDescriptorContainer = mapMakerDescriptorContainer,
        _selectBallUseCaseInputPort = selectBallUseCaseInputPort,
        _geoLocationUtilForeGroundUseCase = geoLocationUtilForeGroundUseCase {

    initCameraPosition = new CameraPosition(
        zoom: 14.56,
        target: LatLng(initPosition.latitude, initPosition.longitude));
    markers = Set<Marker>();
    currentPosition = initCameraPosition;
    this.initMap();
  }

  initMap() async {
    userPosition =
        _geoLocationUtilForeGroundUseCase.getCurrentWithLastPositionInMemory();
    FBallResDto fBallResDto =
        await _selectBallUseCaseInputPort.selectBall(ballUuid);
    Position ballPosition = Position(
        latitude: fBallResDto.latitude, longitude: fBallResDto.longitude);
    markers.add(_mapBallMarkerFactory.getBallMaker(
        fBallResDto.ballType, ballUuid, ballPosition));
    markers.add(Marker(
      markerId: MarkerId("UserProfileImage"),
      icon: _mapMakerDescriptorContainer.getBitmapDescriptor(MapMakerDescriptorType.UserAvatarIcon),
      anchor: Offset(0.5, 0.5),
      position: LatLng(userPosition.latitude, userPosition.longitude),
    ));
    notifyListeners();
  }

  void onCreateMap(GoogleMapController controller) async {
    _googleMapController.complete(controller);
  }

  void mapMoveBallPosition() async {
    GoogleMapController googleMapController = await _googleMapController.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(initPosition.latitude, initPosition.longitude),
            zoom: 14.56)));
  }


  void onCameraIdle() async{
    bool tempIsBallPosition = isBallPosition;
    if(currentPosition.target == LatLng(initPosition.latitude, initPosition.longitude)){
      isBallPosition = true;
    }else {
      isBallPosition = false;
    }
    if(tempIsBallPosition != isBallPosition){
      notifyListeners();
    }
  }

  void onCameraMove(CameraPosition position) {
    currentPosition = position;
  }
}
