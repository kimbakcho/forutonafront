import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ID001Map extends StatefulWidget {
  final Position _ballPosition;
  final String _ballAddress;
  final GeoLocationUtilForeGroundUseCaseInputPort
  _geoLocationUtilForeGroundUseCase;
  final MapMakerDescriptorContainer _mapMakerDescriptorContainer;

  ID001Map({Position ballPosition,
    String ballAddress,
    GeoLocationUtilForeGroundUseCaseInputPort
    geoLocationUtilForeGroundUseCase,
    MapMakerDescriptorContainer mapMakerDescriptorContainer})
      : _ballPosition = ballPosition,
        _ballAddress = ballAddress,
        _geoLocationUtilForeGroundUseCase = geoLocationUtilForeGroundUseCase,
        _mapMakerDescriptorContainer = mapMakerDescriptorContainer;

  @override
  _ID001MapState createState() => _ID001MapState();
}

class _ID001MapState extends State<ID001Map> with WidgetsBindingObserver {
  String userProfileImageUrl;
  Position userPosition;
  Preference _preference = sl();
  CameraPosition initCameraPosition;
  Key mapKey = UniqueKey();
  Set<Marker> markers = Set<Marker>();

  @override
  void initState() {
    super.initState();
    userProfileImageUrl = _preference.basicProfileImageUrl;
    userPosition = _preference.initPosition;
    initCameraPosition = CameraPosition(
        target: LatLng(
            widget._ballPosition.latitude, widget._ballPosition.longitude),
        zoom: 14.56);
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  init() async {
    await setMarkers();
    setState(() {});
  }

  setMarkers() async {
    markers.add(Marker(
      markerId: MarkerId("IssueBall"),
      icon: widget._mapMakerDescriptorContainer.getBitmapDescriptor("IssueBallIcon"),
      position:
      LatLng(widget._ballPosition.latitude, widget._ballPosition.longitude),
    ));

    markers.add(Marker(
      markerId: MarkerId("UserProfileImage"),
      icon: widget._mapMakerDescriptorContainer.getBitmapDescriptor("UserAvatarIcon"),
      position: LatLng(widget._ballPosition.latitude + 0.0001,
          widget._ballPosition.longitude + 0.0001),
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
      height: 185,
      child: GoogleMap(
        key: mapKey,
        initialCameraPosition: initCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomGesturesEnabled: false,
      ),
    );
  }

}
