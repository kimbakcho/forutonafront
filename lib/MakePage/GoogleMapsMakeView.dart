import 'dart:typed_data';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:search_map_place/search_map_place.dart';
import 'Component/CubeMakeAndList.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

const kGoogleApiKey = "AIzaSyAyyDPdP91f5RgxKjXbAPZr0lBVSyeZbGU";

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

  // bool _isMapCreated = false;
  // bool _isMoving = false;
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
  String error;
  // CameraPosition _currentCameraPosition;

  // Position _lastKnownPosition;
  // Position _currentPosition;
  Geolocator searchgeolocator = Geolocator();
  Set<Marker> markers = Set<Marker>();
  Marker selectMarker;
  Uint8List _selectmarkerIcon;

  @override
  void initState() {
    super.initState();
    geolocationinit();
    _makerImageInit();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void _makerImageInit() async {
    _selectmarkerIcon =
        await getBytesFromAsset('assets/MarkesImages/SelectMarker.png', 100);
  }

  geolocationinit() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.location, PermissionGroup.locationAlways]);

    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    if ((geolocationStatus.value == 2) || (geolocationStatus.value == 3)) {
      setState(() {
        // _lastKnownPosition = null;
        // _currentPosition = null;
      });
      _initLastKnownLocation();
      _initCurrentLocation();
    } else {
      Navigator.pop(context);
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controller = controller;
      // _isMapCreated = true;
    });
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      // LatLng value = _currentCameraPosition.target;
      // _currentCameraPosition = position;
    });
  }

  Future<void> _initLastKnownLocation() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = !true;
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
      _kInitialPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 16);
      _controller.moveCamera(CameraUpdate.newCameraPosition(_kInitialPosition));
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }
    setState(() {
      // _lastKnownPosition = position;
    });
  }

  _initCurrentLocation() async {
    Geolocator()
      ..forceAndroidLocationManager = !true
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {
          setState(() {
            _controller.moveCamera(CameraUpdate.newCameraPosition(
                _kInitialPosition = CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 16)));

            selectMarker = Marker(
                markerId: MarkerId("selectMarter"),
                position: LatLng(position.latitude, position.longitude),
                icon: BitmapDescriptor.fromBytes(_selectmarkerIcon));
            markers.add(selectMarker);
            // _currentPosition = position;
          });
        }
      }).catchError((e) {
        //
      });
  }

  void _googlemaptap(LatLng latlang) {
    markers.removeWhere((test) {
      if (test.markerId.value == "selectMarter") {
        return true;
      } else {
        return false;
      }
    });
    selectMarker = Marker(
        markerId: MarkerId("selectMarter"),
        position: latlang,
        icon: BitmapDescriptor.fromBytes(_selectmarkerIcon));
    markers.add(selectMarker);
    setState(() {});
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
      onTap: _googlemaptap,
      markers: markers,
    );
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(margin: EdgeInsets.only(top: 90), child: googleMap),
      Positioned(
        top: MediaQuery.of(context).size.height * 0.75,
        child: CubeMakeAndList(),
      ),
      Positioned(
          top: 30,
          left: MediaQuery.of(context).size.width * 0.17,
          child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: SearchMapPlaceWidget(
                apiKey: kGoogleApiKey,
                location: _kInitialPosition.target,
                language: "ko",
                radius: 30000,
                onSelected: (place) async {
                  final geolocation = await place.geolocation;
                  _controller.animateCamera(
                      CameraUpdate.newLatLng(geolocation.coordinates));
                  _controller.animateCamera(
                      CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                },
              ))),
      Positioned(
        top: 30,
        left: 2,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.15,
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close),
          ),
        ),
      )
    ]));

    // CustomSearchScaffold();
  }
}
