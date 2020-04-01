import 'package:after_init/after_init.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/IssueCube/IM001MainStep1.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
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
  CameraPosition currentCameraPosition;
  bool isloading = false;

  String selectflareartborad() {
    if (this.selectFcube.cubetype == FcubeType.issuecube) {
      return "IssueAni";
    } else if (this.selectFcube.cubetype == FcubeType.questCube) {
      return "QuestAni";
    } else {
      return "IssueAni";
    }
  }

  String selectCubetext() {
    if (this.selectFcube.cubetype == FcubeType.issuecube) {
      return "이슈 큐브";
    } else if (this.selectFcube.cubetype == FcubeType.questCube) {
      return "퀘스트 큐브";
    } else {
      return "이슈 큐브";
    }
  }

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
    currentCameraPosition = _kInitialPosition;
  }

  onMapCreated(GoogleMapController googleMapController) {
    this.googleMapController = googleMapController;

  }

  onCameraMove(CameraPosition position) {
    currentCameraPosition = position;
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
      onCameraMove: onCameraMove,
      onCameraMoveStarted: onCameraMoveStarted,
      onCameraIdle: onCameraIdle,
    );
    return LoadingOverlay(
        isLoading: isloading,
        progressIndicator: Loading(
            indicator: BallScaleIndicator(),
            size: 100.0,
            color: Theme.of(context).accentColor),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                  child: Stack(
                children: <Widget>[
                  googleMap,
                  Center(
                    child: Container(
                        margin: EdgeInsets.only(bottom: 120),
                        width: 80,
                        height: 120,
                        child: FlareActor(
                          "assets/Rive/MakerAni.flr",
                          alignment: Alignment.center,
                          artboard: selectflareartborad(),
                          animation: moveingcameraflag ? "jump" : "down",
                          fit: BoxFit.contain,
                        )),
                  ),
                  Positioned(
                      top: 100,
                      right: 16,
                      child: Container(
                        child: FlatButton(
                          onPressed: () async {
                            Position position =
                                await geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.best);
                            CameraPosition cameraPosition = CameraPosition(
                                target: LatLng(
                                    position.latitude, position.longitude),
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
                              CameraUpdate.newLatLngBounds(
                                  geolocation.bounds, 0));
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
                                  child: Text("${selectCubetext()}를 설치 합니다.",
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
                                      color:
                                          Color(0xff000000).withOpacity(0.16),
                                      blurRadius: 6,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12.00),
                                ))
                            : Container(
                                alignment: Alignment.center,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () async {
                                    isloading = true;
                                    setState(() {});
                                    selectFcube.latitude =
                                        currentCameraPosition.target.latitude;
                                    selectFcube.longitude =
                                        currentCameraPosition.target.longitude;
                                    await selectFcube.getAddress();

                                    // print(selectFcube.placeaddress);

                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return IM001MainStep1(
                                          selectfcube: selectFcube);
                                    }));
                                    isloading = false;
                                    setState(() {});
                                  },
                                  child: Text("${selectCubetext()}를 설치 합니다.",
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
                                      color:
                                          Color(0xff000000).withOpacity(0.16),
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
        ));
  }
}
