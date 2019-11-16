import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestDetailSetupView.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/QuestCheckInCubeTextEditView.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/QuestMessageBoxTextEditView.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FQuestCubeDetailCubeSetupView extends StatefulWidget {
  final FcubeQuest fcubeQuest;
  FQuestCubeDetailCubeSetupView({Key key, this.fcubeQuest}) : super(key: key);

  @override
  _FQuestCubeDetailCubeSetupViewState createState() {
    return _FQuestCubeDetailCubeSetupViewState(fcubeQuest: fcubeQuest);
  }
}

class _FQuestCubeDetailCubeSetupViewState
    extends State<FQuestCubeDetailCubeSetupView> {
  FcubeQuest fcubeQuest;
  _FQuestCubeDetailCubeSetupViewState({this.fcubeQuest});
  GoogleMapController googlemap_controller;
  CameraPosition _kInitialPosition;
  PanelController panelcontroller;
  bool isonPanelOpened = false;
  String currentSelectCubeType = "";
  int currentMessagecubeindex = 0;
  int currentCheckincubeindex = 0;
  Set<Marker> markers = Set<Marker>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    panelcontroller = new PanelController();
    isonPanelOpened = true;

    initQuestCubeLocation();
    initcurrentselectcube();
    fcubeQuest.messagecubeLocations = new List<MessageCubeLocation>();
    fcubeQuest.messagecubeLocations.add(MessageCubeLocation());
    fcubeQuest.checkincubeLocations = new List<CheckinCubeLocation>();
    fcubeQuest.checkincubeLocations.add(CheckinCubeLocation());
    initbottombarshow();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
    fcubeQuest.currentselectcube = null;
    fcubeQuest.startCubeLocation = null;
    fcubeQuest.finishCubeLocation = null;
    fcubeQuest.checkincubeLocations = null;
    fcubeQuest.messagecubeLocations = null;
  }

  void initcurrentselectcube() {
    Future.delayed(Duration.zero, () async {
      fcubeQuest.currentselectcube = new CurrentSelectCubeLocation();
      fcubeQuest.currentselectcube.latitude = fcubeQuest.latitude + 0.0005;
      fcubeQuest.currentselectcube.longitude = fcubeQuest.longitude;

      fcubeQuest.currentselectcube.currentselectmaker = Marker(
          markerId: MarkerId(FcubeType.currentselectcube),
          icon: await Fcube.getMarkerImage(
              CurrentSelectCubeLocation.currentSelectCubeIconPath, 100),
          position: LatLng(fcubeQuest.currentselectcube.latitude,
              fcubeQuest.currentselectcube.longitude));
    });
  }

  void initbottombarshow() async {
    Future.delayed(Duration.zero, () {
      panelcontroller.open();
    });
  }

  initQuestCubeLocation() {
    _kInitialPosition = CameraPosition(
        target: LatLng(fcubeQuest.latitude - 0.001, fcubeQuest.longitude),
        zoom: 16);
  }

  void onMapCreated(GoogleMapController controller) async {
    googlemap_controller = controller;
    BitmapDescriptor markericon =
        await Fcube.getMarkerImage(fcubeQuest.cubeimage, 100);
    markers.add(Marker(
        markerId: MarkerId(fcubeQuest.cubeuuid),
        icon: markericon,
        position: LatLng(fcubeQuest.latitude, fcubeQuest.longitude)));
    markers.add(fcubeQuest.currentselectcube.currentselectmaker);
    setState(() {});
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      // LatLng value = _currentCameraPosition.target;
      // _currentCameraPosition = position;
    });
  }

  void onpanelopend() {
    print("onpanelopend");

    setState(() {
      isonPanelOpened = true;
    });
  }

  void onPanelClosed() {
    print("onPanelClosed");
    setState(() {
      isonPanelOpened = false;
    });
  }

  void onPanelSlide(double value) {
    print("onPanelSlide $value");
  }

  void _googlemaptap(LatLng latlang) {
    Marker tempcurrentmaker = fcubeQuest.currentselectcube.currentselectmaker
        .copyWith(positionParam: latlang);
    markers.remove(fcubeQuest.currentselectcube.currentselectmaker);
    fcubeQuest.currentselectcube.currentselectmaker = tempcurrentmaker;
    fcubeQuest.currentselectcube.latitude = latlang.latitude;
    fcubeQuest.currentselectcube.longitude = latlang.longitude;
    markers.add(tempcurrentmaker);
    setState(() {});
  }

  Widget _expendCollapsedRow(
      {String title, String discirption, String imageurl, Function onclick}) {
    return FlatButton(
        onPressed: () {
          onclick();
        },
        child: Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(imageurl),
                )),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(title),
                  ),
                  Container(
                      child: Text(discirption,
                          style: TextStyle(color: Colors.grey, fontSize: 12)))
                ],
              ),
            )
          ],
        ));
  }

  Widget selectTopCollapsed(String selectcubetype) {
    if (selectcubetype == "") {
      return Container(width: 0);
    } else if (selectcubetype == FcubeType.startcube) {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(125, 255, 255, 255),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                AssetImage cubeimage;
                if (fcubeQuest.startCubeLocation != null &&
                    fcubeQuest.startCubeLocation.startmaker != null) {
                  cubeimage = AssetImage("assets/MarkesImages/cubeEmpty.png");
                } else {
                  cubeimage = AssetImage("assets/MarkesImages/TempCube.png");
                }
                return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: cubeimage, fit: BoxFit.fill)),
                    child: FlatButton(
                      child: Container(),
                      onPressed: () {
                        if (fcubeQuest.startCubeLocation != null &&
                            fcubeQuest.startCubeLocation.startmaker != null) {
                          googlemap_controller.animateCamera(
                              CameraUpdate.newLatLng(fcubeQuest
                                  .startCubeLocation.startmaker.position));
                        }
                      },
                    ));
              },
            ))),
            Container(
              padding: EdgeInsets.only(left: 20),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("스타팅 박스"),
                      Text("어디에서나 퀘스트를 시작할수 있습니다.")
                    ],
                  )),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      child: fcubeQuest.startCubeLocation != null
                          ? Text("설치해제")
                          : Text("설치"),
                      onPressed: () async {
                        if (fcubeQuest.startCubeLocation == null) {
                          fcubeQuest.startCubeLocation =
                              new StartCubeLocation();
                          fcubeQuest.startCubeLocation.startmaker = Marker(
                              markerId: MarkerId(FcubeType.startcube),
                              position: fcubeQuest.currentselectcube
                                  .currentselectmaker.position,
                              icon: await Fcube.getMarkerImage(
                                  StartCubeLocation.cubeimagepath, 100));
                          markers.add(fcubeQuest.startCubeLocation.startmaker);
                          fcubeQuest.startCubeLocation.latitude = fcubeQuest
                              .startCubeLocation.startmaker.position.latitude;
                          fcubeQuest.startCubeLocation.longitude = fcubeQuest
                              .startCubeLocation.startmaker.position.longitude;
                        } else {
                          markers
                              .remove(fcubeQuest.startCubeLocation.startmaker);
                          fcubeQuest.startCubeLocation = null;
                        }
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 1,
            )
          ],
        ),
      );
    } else if (selectcubetype == FcubeType.finishcube) {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(125, 255, 255, 255),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                AssetImage cubeimage;
                if (fcubeQuest.finishCubeLocation != null &&
                    fcubeQuest.finishCubeLocation.finishmaker != null) {
                  cubeimage = AssetImage("assets/MarkesImages/cubeEmpty.png");
                } else {
                  cubeimage = AssetImage("assets/MarkesImages/TempCube.png");
                }
                return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: cubeimage, fit: BoxFit.fill)),
                    child: FlatButton(
                      child: Container(),
                      onPressed: () {
                        if (fcubeQuest.finishCubeLocation != null &&
                            fcubeQuest.finishCubeLocation.finishmaker != null) {
                          googlemap_controller.animateCamera(
                              CameraUpdate.newLatLng(fcubeQuest
                                  .finishCubeLocation.finishmaker.position));
                        }
                      },
                    ));
              },
            ))),
            Container(
              padding: EdgeInsets.only(left: 20),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("피니쉬 큐브"),
                      Text("어디에서나 완료 신청 할수 있습니다.")
                    ],
                  )),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      child: fcubeQuest.finishCubeLocation != null
                          ? Text("설치해제")
                          : Text("설치"),
                      onPressed: () async {
                        if (fcubeQuest.finishCubeLocation == null) {
                          fcubeQuest.finishCubeLocation =
                              new FinishCubeLocation();
                          fcubeQuest.finishCubeLocation.finishmaker = Marker(
                              markerId: MarkerId(FcubeType.finishcube),
                              position: fcubeQuest.currentselectcube
                                  .currentselectmaker.position,
                              icon: await Fcube.getMarkerImage(
                                  FinishCubeLocation.cubeimagepath, 100));
                          markers
                              .add(fcubeQuest.finishCubeLocation.finishmaker);
                          fcubeQuest.finishCubeLocation.latitude = fcubeQuest
                              .finishCubeLocation.finishmaker.position.latitude;
                          fcubeQuest.finishCubeLocation.longitude = fcubeQuest
                              .finishCubeLocation
                              .finishmaker
                              .position
                              .longitude;
                        } else {
                          markers.remove(
                              fcubeQuest.finishCubeLocation.finishmaker);
                          fcubeQuest.finishCubeLocation = null;
                        }
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 1,
            )
          ],
        ),
      );
    } else if (selectcubetype == FcubeType.messageCube) {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(125, 255, 255, 255),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: fcubeQuest.messagecubeLocations.length,
              itemBuilder: (context, index) {
                AssetImage cubeimage;
                if (fcubeQuest.messagecubeLocations[index].ismarkersetuponmap) {
                  cubeimage = AssetImage("assets/MarkesImages/cubeEmpty.png");
                } else {
                  cubeimage = AssetImage("assets/MarkesImages/TempCube.png");
                }
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: cubeimage, fit: BoxFit.contain)),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      currentMessagecubeindex = index;
                      if (fcubeQuest
                          .messagecubeLocations[currentMessagecubeindex]
                          .ismarkersetuponmap) {
                        googlemap_controller.animateCamera(
                            CameraUpdate.newLatLng(fcubeQuest
                                .messagecubeLocations[currentMessagecubeindex]
                                .messagemaker
                                .position));
                      }
                      setState(() {});
                    },
                    child: Container(),
                  ),
                );
              },
            ))),
            Container(
              padding: EdgeInsets.only(left: 20),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("메시지 규브"),
                      Text("어디에서나 확인할수 있는 메시지박스를 설치 합니다.")
                    ],
                  )),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      child: fcubeQuest
                              .messagecubeLocations[currentMessagecubeindex]
                              .ismarkersetuponmap
                          ? Text("설치해제")
                          : Text("설치"),
                      onPressed: () async {
                        if (!fcubeQuest
                            .messagecubeLocations[currentMessagecubeindex]
                            .ismarkersetuponmap) {
                          fcubeQuest
                                  .messagecubeLocations[currentMessagecubeindex]
                                  .messagemaker =
                              Marker(
                                  markerId:
                                      MarkerId("MB$currentMessagecubeindex"),
                                  position: fcubeQuest.currentselectcube
                                      .currentselectmaker.position,
                                  icon: await Fcube.getMarkerImage(
                                      MessageCubeLocation.cubeimagepath, 100));
                          String resultmessage = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return QuestMessageCubeTextEditView(
                              fcubeQuest: fcubeQuest,
                              messagecubeindex: currentMessagecubeindex,
                            );
                          }));
                          if (resultmessage == "sucess") {
                            markers.add(fcubeQuest
                                .messagecubeLocations[currentMessagecubeindex]
                                .messagemaker);
                            fcubeQuest
                                    .messagecubeLocations[currentMessagecubeindex]
                                    .latitude =
                                fcubeQuest
                                    .messagecubeLocations[
                                        currentMessagecubeindex]
                                    .messagemaker
                                    .position
                                    .latitude;
                            fcubeQuest
                                    .messagecubeLocations[currentMessagecubeindex]
                                    .longitude =
                                fcubeQuest
                                    .messagecubeLocations[
                                        currentMessagecubeindex]
                                    .messagemaker
                                    .position
                                    .longitude;

                            fcubeQuest
                                .messagecubeLocations[currentMessagecubeindex]
                                .ismarkersetuponmap = true;
                            fcubeQuest.messagecubeLocations
                                .add(MessageCubeLocation());
                            currentMessagecubeindex++;
                          }
                        } else {
                          markers.remove(fcubeQuest
                              .messagecubeLocations[currentMessagecubeindex]
                              .messagemaker);
                          fcubeQuest.messagecubeLocations
                              .removeAt(currentMessagecubeindex);
                        }
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 1,
            )
          ],
        ),
      );
    } else if (selectcubetype == FcubeType.checkincube) {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(125, 255, 255, 255),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: fcubeQuest.checkincubeLocations.length,
              itemBuilder: (context, index) {
                AssetImage cubeimage;
                if (fcubeQuest.checkincubeLocations[index].ismarkersetuponmap) {
                  cubeimage = AssetImage("assets/MarkesImages/cubeEmpty.png");
                } else {
                  cubeimage = AssetImage("assets/MarkesImages/TempCube.png");
                }
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: cubeimage, fit: BoxFit.contain)),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      currentCheckincubeindex = index;
                      if (fcubeQuest
                          .checkincubeLocations[currentCheckincubeindex]
                          .ismarkersetuponmap) {
                        googlemap_controller.animateCamera(
                            CameraUpdate.newLatLng(fcubeQuest
                                .checkincubeLocations[currentCheckincubeindex]
                                .checkincubemaker
                                .position));
                      }
                      setState(() {});
                    },
                    child: Container(),
                  ),
                );
              },
            ))),
            Container(
              padding: EdgeInsets.only(left: 20),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("체크인 큐브"),
                      Text("체크인 하여 확인 가능한 메세지 박스를 설치 합니다.")
                    ],
                  )),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      child: fcubeQuest
                              .checkincubeLocations[currentCheckincubeindex]
                              .ismarkersetuponmap
                          ? Text("설치해제")
                          : Text("설치"),
                      onPressed: () async {
                        if (!fcubeQuest
                            .checkincubeLocations[currentCheckincubeindex]
                            .ismarkersetuponmap) {
                          fcubeQuest
                                  .checkincubeLocations[currentCheckincubeindex]
                                  .checkincubemaker =
                              Marker(
                                  markerId:
                                      MarkerId("CB$currentCheckincubeindex"),
                                  position: fcubeQuest.currentselectcube
                                      .currentselectmaker.position,
                                  icon: await Fcube.getMarkerImage(
                                      CheckinCubeLocation.cubeimagepath, 100));
                          String resultmessage = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return QuestCheckInCubeTextEditView(
                              fcubeQuest: fcubeQuest,
                              checkincubeindex: currentCheckincubeindex,
                            );
                          }));
                          if (resultmessage == "sucess") {
                            markers.add(fcubeQuest
                                .checkincubeLocations[currentCheckincubeindex]
                                .checkincubemaker);

                            fcubeQuest
                                    .checkincubeLocations[currentCheckincubeindex]
                                    .latitude =
                                fcubeQuest
                                    .checkincubeLocations[
                                        currentCheckincubeindex]
                                    .checkincubemaker
                                    .position
                                    .latitude;

                            fcubeQuest
                                    .checkincubeLocations[currentCheckincubeindex]
                                    .longitude =
                                fcubeQuest
                                    .checkincubeLocations[
                                        currentCheckincubeindex]
                                    .checkincubemaker
                                    .position
                                    .longitude;

                            fcubeQuest
                                .checkincubeLocations[currentCheckincubeindex]
                                .ismarkersetuponmap = true;
                            fcubeQuest.checkincubeLocations
                                .add(CheckinCubeLocation());
                            currentCheckincubeindex++;
                          }
                        } else {
                          markers.remove(fcubeQuest
                              .checkincubeLocations[currentCheckincubeindex]
                              .checkincubemaker);
                          fcubeQuest.checkincubeLocations
                              .removeAt(currentCheckincubeindex);
                        }
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 1,
            )
          ],
        ),
      );
    }
    return Container(width: 0);
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
        onMapCreated: onMapCreated,
        compassEnabled: true,
        initialCameraPosition: _kInitialPosition,
        cameraTargetBounds: CameraTargetBounds.unbounded,
        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
        rotateGesturesEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        indoorViewEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onCameraMove: _updateCameraPosition,
        onTap: _googlemaptap,
        markers: markers);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FcubeQuestDetailSetupView(fcubeQuest: fcubeQuest);
                }));
              },
              child: Text("다음"),
            ),
          )
        ],
      ),
      body: SlidingUpPanel(
          minHeight: currentSelectCubeType.length == 0 ? 50 : 210,
          controller: panelcontroller,
          maxHeight: MediaQuery.of(context).size.height * 0.4,
          onPanelOpened: onpanelopend,
          onPanelClosed: onPanelClosed,
          onPanelSlide: onPanelSlide,
          color: isonPanelOpened
              ? Color.fromARGB(255, 255, 255, 255)
              : Color.fromARGB(0, 255, 255, 255),
          panel: isonPanelOpened
              ? Column(
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    Expanded(
                      child: Container(
                          child: _expendCollapsedRow(
                              title: "스타팅 큐브",
                              discirption: "시작 장소를 지정합니다",
                              imageurl: "assets/MarkesImages/TempCube.png",
                              onclick: () {
                                currentSelectCubeType = FcubeType.startcube;
                                panelcontroller.close();
                                setState(() {});
                              })),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 2,
                    ),
                    Expanded(
                      child: Container(
                          child: _expendCollapsedRow(
                              title: "피니싱 큐브",
                              discirption: "완료장소를 지정합니다.",
                              imageurl: "assets/MarkesImages/TempCube.png",
                              onclick: () {
                                currentSelectCubeType = FcubeType.finishcube;
                                panelcontroller.close();
                              })),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 2,
                    ),
                    Expanded(
                      child: Container(
                          child: _expendCollapsedRow(
                              title: "메세지 큐브",
                              discirption: "어디서나 확인가능한메시지박스를설치합니다.",
                              imageurl: "assets/MarkesImages/TempCube.png",
                              onclick: () {
                                currentSelectCubeType = FcubeType.messageCube;
                                panelcontroller.close();
                              })),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 2,
                    ),
                    Expanded(
                      child: Container(
                          child: _expendCollapsedRow(
                              title: "체크인 큐브",
                              discirption: "체크인 하여 확인 가능한 메시지 박스를 설치합니다.",
                              imageurl: "assets/MarkesImages/TempCube.png",
                              onclick: () {
                                currentSelectCubeType = FcubeType.checkincube;
                                panelcontroller.close();
                              })),
                    ),
                  ],
                )
              : Container(),
          collapsed: Container(
              child: Column(
            children: <Widget>[
              Expanded(
                child: selectTopCollapsed(currentSelectCubeType),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 40,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            currentSelectCubeType = FcubeType.startcube;
                          });
                        },
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/MarkesImages/TempCube.png"),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            currentSelectCubeType = FcubeType.finishcube;
                          });
                        },
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/MarkesImages/TempCube.png"),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            currentSelectCubeType = FcubeType.messageCube;
                          });
                        },
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/MarkesImages/TempCube.png"),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            currentSelectCubeType = FcubeType.checkincube;
                          });
                        },
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/MarkesImages/TempCube.png"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 40,
                      child: FlatButton(
                        onPressed: () {
                          panelcontroller.open();
                        },
                        padding: EdgeInsets.all(0),
                        shape: new CircleBorder(),
                        color: Colors.blueGrey,
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
          body: Container(
            child: googleMap,
          )),
    );

    // Stack(
    //   children: <Widget>[googleMap],
    // ),
  }
}
