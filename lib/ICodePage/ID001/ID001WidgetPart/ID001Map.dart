import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseForeGroundCaseOutputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/Common/MapIntentButton/MapintentButton.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/ICodePage/IBM001/IMB001FullScreenMap.dart';
import 'package:forutonafront/Preference.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ID001Map extends StatefulWidget {
  final Position _ballPosition;
  final String _ballUuid;
  final String _ballAddress;
  final GeoLocationUtilForeGroundUseCaseInputPort
      _geoLocationUtilForeGroundUseCase;
  final MapMakerDescriptorContainer _mapMakerDescriptorContainer;
  final MapBallMarkerFactory _mapBallMarkerFactory;

  ID001Map(
      {Position ballPosition,
      String ballAddress,
      String ballUuid,
      GeoLocationUtilForeGroundUseCaseInputPort
          geoLocationUtilForeGroundUseCase,
      MapMakerDescriptorContainer mapMakerDescriptorContainer,
      MapBallMarkerFactory mapBallMarkerFactory})
      : _ballPosition = ballPosition,
        _ballAddress = ballAddress,
        _ballUuid = ballUuid,
        _geoLocationUtilForeGroundUseCase = geoLocationUtilForeGroundUseCase,
        _mapMakerDescriptorContainer = mapMakerDescriptorContainer,
        _mapBallMarkerFactory = mapBallMarkerFactory;

  @override
  _ID001MapState createState() => _ID001MapState();
}

class _ID001MapState extends State<ID001Map>
    with WidgetsBindingObserver
    implements GeoLocationUtilUseForeGroundCaseOutputPort {
  String userProfileImageUrl;
  Position userPosition;

  CameraPosition initCameraPosition;
  Key mapKey = UniqueKey();
  Set<Marker> markers = Set<Marker>();
  String ballDistanceFromUser = "";

  @override
  void initState() {
    super.initState();
    userProfileImageUrl = Preference.basicProfileImageUrl;

    initCameraPosition = CameraPosition(
        target: LatLng(
            widget._ballPosition.latitude, widget._ballPosition.longitude),
        zoom: 14.56);
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  init() async {
    userPosition = widget._geoLocationUtilForeGroundUseCase
        .getCurrentWithLastPositionInMemory();
    widget._geoLocationUtilForeGroundUseCase.reqBallDistanceDisplayText(
        ballLatLng: widget._ballPosition, geoLocationUtilUseCaseOp: this);
    await setMarkers();
    setState(() {});
  }

  setMarkers() async {
    markers.add(widget._mapBallMarkerFactory.getBallMaker(
        FBallType.IssueBall, widget._ballUuid, widget._ballPosition));
    markers.add(Marker(
      markerId: MarkerId("UserProfileImage"),
      icon: widget._mapMakerDescriptorContainer
          .getBitmapDescriptor(MapMakerDescriptorType.UserAvatarIcon),
      anchor: Offset(0.5, 0.5),
      position: LatLng(userPosition.latitude, userPosition.longitude),
    ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
//    reRenderGoogleMap();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return IMB001FullScreenMap(
                  initAddress: widget._ballAddress,
                    initPosition: widget._ballPosition,
                    ballUuid: widget._ballUuid);
              }));
            },
            child: Container(
              height: 185,
              child: IgnorePointer(
                child: GoogleMap(
                  key: mapKey,
                  initialCameraPosition: initCameraPosition,
                  markers: markers,
                  zoomControlsEnabled: false,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomGesturesEnabled: false,
                ),
              ),
            ),
          ),
          bottomBar()
        ],
      ),
      mapIntentButton()
    ]));
  }

  Container bottomBar() {
    return Container(
        height: 35,
        decoration: BoxDecoration(color: Color(0xffF4F4F6)),
        child: Row(children: <Widget>[
          Expanded(
              child: Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Color(0xff454F63),
                        size: 15,
                      ),
                      Expanded(child: addressDisplayText())
                    ],
                  ))),
          Container(
            margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
            width: 1,
            color: Color(0xffE4E7E8),
          ),
          ballWithUserDistanceText(),
          SizedBox(
            width: 70,
          ),
        ]));
  }

  Container addressDisplayText() {
    return Container(
        margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: Text(
          widget._ballAddress,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.notoSans(
            fontSize: 13,
            color: const Color(0xff454f63),
            letterSpacing: -0.26,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ));
  }

  Container ballWithUserDistanceText() {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Text(
          ballDistanceFromUser,
          style: GoogleFonts.notoSans(
            fontSize: 13,
            color: const Color(0xffff5d76),
            letterSpacing: -0.26,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ));
  }

  Positioned mapIntentButton() {
    return Positioned(
      bottom: 16,
      right: 16,
      width: 45,
      height: 45,
      child: MapIntentButton(
        dstPosition: widget._ballPosition,
        dstAddress: widget._ballAddress,
      ),
    );
  }

  @override
  onBallDistanceDisplayText({String displayDistanceText}) {
    setState(() {
      this.ballDistanceFromUser = displayDistanceText;
    });
  }
}
