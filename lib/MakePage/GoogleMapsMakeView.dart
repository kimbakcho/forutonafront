import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class GoogleMapsMakeView extends StatefulWidget {
  GoogleMapsMakeView({Key key}) : super(key: key);

  @override
  _GoogleMapsMakeViewState createState() => _GoogleMapsMakeViewState();
}

class _GoogleMapsMakeViewState extends State<GoogleMapsMakeView> {
  CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(37.550944, 126.990819),
    zoom: 16.0,
  );
  bool _isMapCreated = false;
  bool _isMoving = false;
  bool _compassEnabled = true;
  bool _mapToolbarEnabled = true;
  CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  MinMaxZoomPreference _minMaxZoomPreference = MinMaxZoomPreference.unbounded;
  MapType _mapType = MapType.normal;
  bool _rotateGesturesEnabled = true;
  bool _scrollGesturesEnabled = true;
  bool _tiltGesturesEnabled = true;
  bool _zoomGesturesEnabled = true;
  bool _indoorViewEnabled = true;
  bool _myLocationEnabled = true;
  bool _myLocationButtonEnabled = true;
  GoogleMapController _controller;
  bool _nightMode = false;
  String error;
  LocationData currentLocation;
  Location _locationService = new Location();
  bool _permission = false;
  StreamSubscription<LocationData> _locationSubscription;
  CameraPosition _currentCameraPosition;
  LocationData _startLocation;
  LocationData _currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initPlatformState();
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);
    LocationData location;
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          _currentCameraPosition = CameraPosition(
              target: LatLng(location.latitude, location.longitude), zoom: 16);
          _controller.moveCamera(
              CameraUpdate.newCameraPosition(_currentCameraPosition));

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;
              });
            }
          });
        } else {
          bool serviceStatusResult = await _locationService.requestService();
          print("Service status activated after request: $serviceStatusResult");
          if (serviceStatusResult) {
            initPlatformState();
          }
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }
    setState(() {
      _startLocation = location;
    });
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controller = controller;
      _isMapCreated = true;
    });
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      LatLng value = _currentCameraPosition.target;
      _currentCameraPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: _kInitialPosition,
      compassEnabled: _compassEnabled,
      mapToolbarEnabled: _mapToolbarEnabled,
      cameraTargetBounds: _cameraTargetBounds,
      minMaxZoomPreference: _minMaxZoomPreference,
      mapType: _mapType,
      rotateGesturesEnabled: _rotateGesturesEnabled,
      scrollGesturesEnabled: _scrollGesturesEnabled,
      tiltGesturesEnabled: _tiltGesturesEnabled,
      zoomGesturesEnabled: _zoomGesturesEnabled,
      indoorViewEnabled: _indoorViewEnabled,
      myLocationEnabled: _myLocationEnabled,
      myLocationButtonEnabled: _myLocationButtonEnabled,
      onCameraMove: _updateCameraPosition,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("google"),
      ),
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(child: googleMap),
        ],
      ),
    );
  }
}
