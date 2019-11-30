import 'dart:typed_data';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FQuestCubePositionSetupView.dart';

import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/Preference.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:search_map_place/search_map_place.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';

class GoogleMapsMakeView extends StatefulWidget {
  final Fcube selectFcube;
  GoogleMapsMakeView({Key key, this.selectFcube}) : super(key: key);

  @override
  _GoogleMapsMakeViewState createState() {
    return _GoogleMapsMakeViewState(selectFcube);
  }
}

class _GoogleMapsMakeViewState extends State<GoogleMapsMakeView> {
  Fcube selectFcube;
  _GoogleMapsMakeViewState(this.selectFcube);
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
  bool _myLocationEnabled = true;
  bool _indoorViewEnabled = true;
  bool _myLocationButtonEnabled = true;
  GoogleMapController _controller;
  String error;
  BitmapDescriptor messageboxicon;

  Geolocator searchgeolocator = Geolocator();
  Set<Marker> markers = Set<Marker>();
  Marker selectMarker;
  Marker currentMakrer;
  Uint8List _selectmarkerIcon;

  Uuid uuid = Uuid();
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
    _selectmarkerIcon = await getBytesFromAsset(
        CurrentSelectCubeLocation.currentSelectCubeIconPath, 100);
  }

  geolocationinit() async {
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
    });
  }
/*
  void setmymarkers() async {
    List<FcubeExtender1> cubelist =
        await FcubeExtender1.getusercubes(offset: 0, limit: 10);
    var messagecubemaker =
        await getBytesFromAsset('assets/MarkesImages/MessageCube.png', 100);
    var message1cubemaker =
        await getBytesFromAsset('assets/MarkesImages/MessageCube.png', 150);
    cubelist.forEach((cube) {
      Marker setcube = Marker(
          markerId: MarkerId(cube.cubeuuid),
          position: LatLng(cube.latitude, cube.longitude),
          icon: BitmapDescriptor.fromBytes(messagecubemaker),
          infoWindow: InfoWindow(title: cube.cubename),
          onTap: () {
            if (currentMakrer != null) {
              Marker recovermemarks = currentMakrer.copyWith(
                  iconParam: BitmapDescriptor.fromBytes(messagecubemaker));
              markers.remove(currentMakrer);
              markers.add(recovermemarks);
            }
            Marker memarks = markers.firstWhere((test) {
              return test.markerId.value == cube.cubeuuid;
            });
            Marker newmemarks = memarks.copyWith(
                iconParam: BitmapDescriptor.fromBytes(message1cubemaker));
            markers.remove(memarks);
            markers.add(newmemarks);
            currentMakrer = newmemarks;
            setState(() {});
          });
      markers.add(setcube);
    });
    setState(() {});
  }
*/

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
            selectFcube.latitude = position.latitude;
            selectFcube.longitude = position.longitude;
            markers.add(selectMarker);
            // _currentPosition = position;
          });
        }
      }).catchError((e) {
        //
      });
  }

  void _googlemaptap(LatLng latlang) {
    Marker tempselectMarker = selectMarker.copyWith(positionParam: latlang);
    markers.remove(selectMarker);
    selectMarker = tempselectMarker;
    selectFcube.latitude = latlang.latitude;
    selectFcube.longitude = latlang.longitude;
    markers.add(selectMarker);
    setState(() {});
  }

  void _selectPushNavi(context) async {
    if (selectFcube.cubetype == FcubeType.messageCube) {
      print("messagecube");
    } else if (selectFcube.cubetype == FcubeType.questCube) {
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FQuestCubePositionSetupView(
          fcubeQuest: new FcubeQuest(cube: selectFcube),
        );
      }));
    }
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
          top: MediaQuery.of(context).size.height * 0.7,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(color: Color(0xADA3A37D)),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment(0, 0),
                  child: Image(
                    image: AssetImage(selectFcube.cubeimage),
                  ),
                ),
                Container(
                  alignment: Alignment(0, 0),
                  child: Text(selectFcube.cubedispalyname),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      child: Text("여기에 설치하기"),
                      onPressed: () async {
                        List<Placemark> placeaddress = await Geolocator()
                            .placemarkFromCoordinates(
                                selectFcube.latitude, selectFcube.longitude,
                                localeIdentifier: "ko");
                        if (placeaddress.length > 0) {
                          selectFcube.country = placeaddress[0].country;
                          selectFcube.administrativearea =
                              placeaddress[0].administrativeArea;
                          selectFcube.placeaddress =
                              placeaddress[0].administrativeArea +
                                  " " +
                                  placeaddress[0].thoroughfare +
                                  " " +
                                  placeaddress[0].subThoroughfare +
                                  placeaddress[0].name;
                        } else {
                          selectFcube.placeaddress =
                              selectFcube.latitude.toStringAsFixed(2) +
                                  "," +
                                  selectFcube.longitude.toStringAsFixed(2);
                        }
                        _selectPushNavi(context);
                      },
                    ))
              ],
            ),
          )),
      Positioned(
          top: 30,
          left: MediaQuery.of(context).size.width * 0.17,
          child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: SearchMapPlaceWidget(
                apiKey: Preference.kGoogleApiKey,
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
