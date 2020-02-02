import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';

class C003GoogleMapMakeView extends StatefulWidget {
  C003GoogleMapMakeView({this.selectFcube, Key key}) : super(key: key);
  final Fcube selectFcube;

  @override
  _C003GoogleMapMakeViewState createState() {
    return _C003GoogleMapMakeViewState(selectFcube);
  }
}

class _C003GoogleMapMakeViewState extends State<C003GoogleMapMakeView>
    with AfterInitMixin {
  _C003GoogleMapMakeViewState(this.selectFcube);
  Fcube selectFcube;
  CameraPosition _kInitialPosition;
  GoogleMapController googleMapController;
  final Geolocator geolocator = Geolocator();
  bool moveingcameraflag = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didInitState() {
    Position currentposition =
        GlobalStateContainer.of(context).state.currentposition;
    _kInitialPosition = CameraPosition(
        target: LatLng(currentposition.latitude, currentposition.longitude),
        zoom: 16);
  }

  onMapCreated(GoogleMapController googleMapController) {
    this.googleMapController = googleMapController;
  }

  onCameraMoveStarted() {
    moveingcameraflag = true;
    setState(() {});
  }

  onCameraIdle() {
    moveingcameraflag = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      initialCameraPosition: _kInitialPosition,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      onMapCreated: onMapCreated,
      onCameraMoveStarted: onCameraMoveStarted,
      onCameraIdle: onCameraIdle,
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              child: Stack(
            children: <Widget>[
              googleMap,
              Center(
                child: Container(child: Text("123")),
              ),
              Positioned(
                  top: 100,
                  right: 16,
                  child: Container(
                    child: FlatButton(
                      onPressed: () async {
                        Position position = await geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.best);
                        CameraPosition cameraPosition = CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 16);
                        this.googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(cameraPosition));
                      },
                      child: Icon(Icons.my_location),
                    ),
                    height: 52.00,
                    width: 52.00,
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
                    ),
                  )),
              Positioned(
                top: 30,
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  width: MediaQuery.of(context).size.width,
                  child: SearchMapPlaceWidget(
                    apiKey: Preference.kGoogleApiKey,
                    location: _kInitialPosition.target,
                    language: "ko",
                    radius: 30000,
                    onSelected: (place) async {
                      final geolocation = await place.geolocation;
                      googleMapController.animateCamera(
                          CameraUpdate.newLatLng(geolocation.coordinates));
                      googleMapController.animateCamera(
                          CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                    },
                  ),
                ),
              ),
              Positioned(
                  bottom: 16,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: moveingcameraflag
                        ? Container(
                            alignment: Alignment.center,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
                              child: Text("이슈 큐브를 설치 합니다.",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white,
                                  )),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffB1B1B1),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.00, 3.00),
                                  color: Color(0xff000000).withOpacity(0.16),
                                  blurRadius: 6,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12.00),
                            ))
                        : Container(
                            alignment: Alignment.center,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
                              child: Text("이슈 큐브를 설치 합니다.",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xff39f999),
                                  )),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff454f63),
                              border: Border.all(
                                width: 1.00,
                                color: Color(0xff39f999),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.00, 3.00),
                                  color: Color(0xff000000).withOpacity(0.16),
                                  blurRadius: 6,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12.00),
                            )),
                  ))
            ],
          )),
        ],
      ),
    );
  }
}
