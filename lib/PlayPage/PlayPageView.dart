import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FCubeGeoSearchUtil.dart';
import 'package:forutonafront/Common/GeoSearchUtil.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/FcubeListUtil.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/globals.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:clustering_google_maps/clustering_google_maps.dart';

class PlayPageView extends StatefulWidget {
  PlayPageView({Key key}) : super(key: key);

  @override
  _PlayPageViewState createState() => _PlayPageViewState();
}

class _PlayPageViewState extends State<PlayPageView> {
  CameraPosition initialCameraPosition;
  Geolocator geolocation = Geolocator();
  Position initposition;
  GoogleMapController googlemap_controller;
  Set<Marker> markers = Set<Marker>();
  bool isloading;
  PanelController panelController = PanelController();
  List<FcubeLatLngAndGeohash> currentvisualPoints = List();
  ClusteringHelper clusteringHelper;
  FcubeTypeMakerImage fcubetypeiamge;

  List<FcubeExtender1> panellistfcube = List<FcubeExtender1>();
  bool isplistloading = false;
  Position initpanelposition;
  int panellistoffet;
  int panellistlimit;

  @override
  void initState() {
    super.initState();
    initimage();
    clusteringHelper = ClusteringHelper.forMemory(
        list: currentvisualPoints,
        updateMarkers: updateMarkers,
        aggregationSetup: AggregationSetup(markerSize: 150),
        onMakertap: onMakertap);
    initialCameraPosition =
        new CameraPosition(target: LatLng(37.550940, 126.990850), zoom: 16);

    initgeolocation();
  }

  onMakertap(FcubeMakerHelper helper) {
    print(helper.cubeuuid);
  }

  initimage() async {
    fcubetypeiamge =
        FcubeTypeMakerImage(big: 150, nomal: 100, iconimagesize: 50);
    await fcubetypeiamge.initImage();
    setState(() {});
  }

  initgeolocation() async {
    initposition = await geolocation.getCurrentPosition();
    initialCameraPosition = new CameraPosition(
        target: LatLng(initposition.latitude, initposition.longitude),
        zoom: 16);
    setState(() {});
  }

  void onMapCreated(GoogleMapController controller) async {
    googlemap_controller = controller;
    clusteringHelper.mapController = controller;
    initposition = await geolocation.getCurrentPosition();
    initialCameraPosition = new CameraPosition(
        target: LatLng(initposition.latitude, initposition.longitude),
        zoom: 16);
    controller
        .moveCamera(CameraUpdate.newCameraPosition(initialCameraPosition));
    //CubeImageinit

    initMemoryClustering(initialCameraPosition);

    // LatLngBounds visibleGegion = await googlemap_controller.getVisibleRegion();
    // double distance = await geolocation.distanceBetween(
    //     initialCameraPosition.target.latitude,
    //     initialCameraPosition.target.longitude,
    //     visibleGegion.northeast.latitude,
    //     visibleGegion.northeast.longitude);

    // FCubeGeoSearchUtil searchitem = FCubeGeoSearchUtil.fromGeoSearchUtil(
    //     GeoSearchUtil(
    //         distance: distance,
    //         latitude: initialCameraPosition.target.latitude,
    //         longitude: initialCameraPosition.target.longitude,
    //         limit: 1000,
    //         offset: 0),
    //     cubescope: 0,
    //     cubestate: 1,
    //     activationtime: DateTime.now());
    // currentvisualfcube = await FcubeExtender1.findNearDistanceCube(searchitem);
    // print("currentvisualfcube.length = ${currentvisualfcube.length}");
    // for (int i = 0; i < currentvisualfcube.length; i++) {
    //   FcubeLatLngAndGeohash tempitem = FcubeLatLngAndGeohash(LatLng(
    //       currentvisualfcube[i].latitude, currentvisualfcube[i].longitude));
    //   tempitem.makerhelp = FcubeMakerHelper(
    //       cubename: currentvisualfcube[i].cubename,
    //       cubeuuid: currentvisualfcube[i].cubeuuid,
    //       cubeType: currentvisualfcube[i].cubetype.toString(),
    //       nickname: currentvisualfcube[i].nickname,
    //       iconmarker:
    //           fcubetypeiamge.nomalimage[currentvisualfcube[i].cubetype]);

    //   currentvisualPoints.add(tempitem);
    // }
    // print("currentvisualPoints.length = ${currentvisualPoints.length}");
    // clusteringHelper.list = currentvisualPoints;
    // clusteringHelper.onCameraMove(initialCameraPosition);
    // clusteringHelper.updateMap();

    setMarkers();
    setState(() {});
  }

  initMemoryClustering(CameraPosition cameraPosition) async {
    LatLngBounds visibleGegion = await googlemap_controller.getVisibleRegion();
    double distance = await geolocation.distanceBetween(
        cameraPosition.target.latitude,
        cameraPosition.target.longitude,
        visibleGegion.northeast.latitude,
        visibleGegion.northeast.longitude);
    FCubeGeoSearchUtil searchitem = FCubeGeoSearchUtil.fromGeoSearchUtil(
        GeoSearchUtil(
            distance: distance,
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude,
            limit: 1000,
            offset: 0),
        cubescope: 0,
        cubestate: 1,
        activationtime: DateTime.now());
    GolobalStateContainer.of(context).setfcubeplayerListUtilisLoading(true);
    GolobalStateContainer.of(context).addfcubeplayerListUtilcubeListwithReset(
        await FcubeExtender1.findNearDistanceCube(searchitem));

    GolobalStateContainer.of(context).setfcubeplayerListUtilisLoading(false);
    GolobalStateContainer.of(context)
        .updatePlayViewCubeListupdatedistancewithme(Position(
            latitude: GolobalStateContainer.of(context)
                .state
                .currentposition
                .latitude,
            longitude: GolobalStateContainer.of(context)
                .state
                .currentposition
                .longitude));
    //await 시 해당 메소드 외에 다시 이 메소드를 실행 시키니 Clear는 awiat 메소드를 다 호출한 다음에 해야함.
    List<FcubeExtender1> cubeList =
        GolobalStateContainer.of(context).state.fcubeplayerListUtil.cubeList;
    currentvisualPoints.clear();
    for (int i = 0; i < cubeList.length; i++) {
      FcubeLatLngAndGeohash tempitem = FcubeLatLngAndGeohash(
          LatLng(cubeList[i].latitude, cubeList[i].longitude));
      tempitem.makerhelp = FcubeMakerHelper(
          cubename: cubeList[i].cubename,
          cubeuuid: cubeList[i].cubeuuid,
          cubeType: cubeList[i].cubetype.toString(),
          nickname: cubeList[i].nickname,
          iconmarker: fcubetypeiamge.nomalimage[cubeList[i].cubetype]);
      currentvisualPoints.add(tempitem);
    }
    clusteringHelper.list = currentvisualPoints;
    clusteringHelper.onCameraMove(cameraPosition);
    clusteringHelper.updateMap();
    print("currentvisualPointsclear.length = ${currentvisualPoints.length}");
    return;
  }

  updateMarkers(Set<Marker> markers) {
    setState(() {
      this.markers = markers;
    });
  }

  //해당 부분 Backend 에서 추후 Asnyc 처리 필요할것으로 예상
  onPanelCameraMove(CameraPosition cameraPosition) {
    initMemoryClustering(cameraPosition);
  }

  //setinit markes
  setMarkers() async {}

  Widget makeMainListPanel() {
    FcubeListUtil fcubeplayerListUtil =
        GolobalStateContainer.of(context).state.fcubeplayerListUtil;
    if (fcubeplayerListUtil.isLoading) {
      return CircularProgressIndicator();
    } else {
      return ListView.builder(
          itemCount: fcubeplayerListUtil.cubeList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            FcubeExtender1 cubeitem = fcubeplayerListUtil.cubeList[index];
            String makeitme = DateFormat("yyyy-MM-dd HH:mm:ss").format(
                DateTime.parse(cubeitem.maketime).add(Duration(hours: 9)));
            List<String> imagelist = new List();
            if (cubeitem.contenttype == FcubecontentType.description) {
              String descriptionjson =
                  json.decode(cubeitem.contentvalue)["description"];
              List<dynamic> description = json.decode(descriptionjson);
              description.forEach((value) {
                Map values = value as Map;
                values.keys.forEach((key) {
                  if (key == "attributes") {
                    if (value[key]["embed"]["type"] == "image") {
                      imagelist.add(value[key]["embed"]["source"]);
                    }
                  }
                });
              });
            }
            String mainImage;
            double calcheight = 0;
            if (imagelist.length > 0) {
              mainImage = imagelist.first;
            } else {
              calcheight = 0.25;
            }

            return Container(
              height: MediaQuery.of(context).size.height * (0.5 - calcheight),
              child: FlatButton(
                onPressed: () {},
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          fcubetypeiamge.iconImage[cubeitem.cubetype] == null
                              ? Container()
                              : fcubetypeiamge.iconImage[cubeitem.cubetype],
                          Expanded(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment(-1, 0),
                                      child: Text(cubeitem.cubename)),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(cubeitem.placeaddress),
                                      ),
                                      Text(
                                          "${cubeitem.distancewithme.round()} m")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(cubeitem.profilepicktureurl),
                            maxRadius: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment(-1, 0),
                                  child: Text(cubeitem.nickname),
                                ),
                                Container(
                                    alignment: Alignment(-1, 0),
                                    child: Text(makeitme)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height *
                          (0.25 - calcheight),
                      child: Stack(
                        children: <Widget>[
                          mainImage != null
                              ? Image(image: NetworkImage(mainImage))
                              : Container(),
                          imagelist.length > 2
                              ? Positioned(
                                  bottom: 0,
                                  right: 10,
                                  child: RaisedButton(
                                    onPressed: () {},
                                    child: Text("+ ${imagelist.length - 1}"),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
  }

  Widget makeMainPanel() {
    final GoogleMap googleMap = GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      initialCameraPosition:
          GolobalStateContainer.of(context).state.mainInitialCameraPosition,
      onMapCreated: onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: markers,
      onCameraMove: onPanelCameraMove,
    );

    return SlidingUpPanel(
      controller: panelController,
      minHeight: MediaQuery.of(context).size.height * 0.2,
      panel: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Center(
                  child: IconButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                ),
                onPressed: () {
                  panelController.close();
                },
              )),
            ),
            Expanded(
                child: Container(
              child: makeMainListPanel(),
            )),
          ],
        ),
      ),
      collapsed: Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext ctxt, int index) {
              return Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.blue,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text("${index}"));
            },
          )),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.57,
              child: googleMap,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentaddress =
        GolobalStateContainer.of(context).state.currentaddress;
    if (currentaddress == null) {
      currentaddress = "";
    }
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Text(currentaddress),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.78,
          child: makeMainPanel(),
        )
      ],
    ));
  }
}
