import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FCubeGeoSearchUtil.dart';
import 'package:forutonafront/Common/GeoSearchUtil.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/FcubeListUtil.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestDetailPage.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/PlayPage/QuestCube/QuestCollapsed.dart';
import 'package:forutonafront/PlayPage/QuestCube/QuestCubeCard.dart';
import 'package:forutonafront/Preference.dart';
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
  CameraPosition currentCameraPosition;
  String currentselectcubeuuid;
  Geolocator geolocation = Geolocator();
  Position initposition;
  GoogleMapController googlemap_controller;
  Set<Marker> markers = Set<Marker>();
  bool isloading;
  PanelController panelController = PanelController();
  List<FcubeLatLngAndGeohash> currentvisualPoints = List();
  ClusteringHelper clusteringHelper;
  FcubeTypeMakerImage fcubetypeiamge;
  ScrollController collapsedscrollcontroller = new ScrollController();
  List<FcubeExtender1> panellistfcube = List<FcubeExtender1>();
  bool isplistloading = false;
  Position initpanelposition;
  int panellistoffet;
  int panellistlimit;
  String currentFindAddredss;
  bool ismarktap = false;

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
    ismarktap = true;
    currentselectcubeuuid = helper.cubeuuid;
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
          iconmarker: fcubetypeiamge.nomalimage[cubeList[i].cubetype],
          selecticonmaker: fcubetypeiamge.bigimage[cubeList[i].cubetype]);
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
    currentCameraPosition = cameraPosition;
  }

  onCameraIdle() {
    if (currentCameraPosition != null) {
      initMemoryClustering(currentCameraPosition);
    }
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
            if (fcubeplayerListUtil.cubeList[index].cubetype ==
                FcubeType.questCube) {
              return QuestCubeCard(
                cubeitem: fcubeplayerListUtil.cubeList[index],
                fcubetypeiamge: fcubetypeiamge,
              );
            } else {
              return Container(
                child: Text("뭔지 모르는 큐브"),
              );
            }
          });
    }
  }

  Widget makeCollapsed() {
    FcubeListUtil fcubeplayerListUtil =
        GolobalStateContainer.of(context).state.fcubeplayerListUtil;
    if (fcubeplayerListUtil.isLoading) {
      return CircularProgressIndicator();
    } else {
      Widget resultwidget = Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            controller: collapsedscrollcontroller,
            scrollDirection: Axis.horizontal,
            itemCount: fcubeplayerListUtil.cubeList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              if (fcubeplayerListUtil.cubeList[index].cubetype ==
                  FcubeType.questCube) {
                return QuestCollapsed(
                  cubeitem: fcubeplayerListUtil.cubeList[index],
                );
              } else {
                return Container(
                  child: Text("무슨 큐브인지 모르겠음"),
                );
              }
            },
          ));
      // 만약 Marktap을 해서 구글 맵을 이동 했다면 List 이동
      Future.delayed(Duration.zero, () {
        if (ismarktap) {
          List<FcubeExtender1> cubelist = GolobalStateContainer.of(context)
              .state
              .fcubeplayerListUtil
              .cubeList;
          int findindex = cubelist.indexWhere((cube) {
            return cube.cubeuuid == currentselectcubeuuid;
          });
          collapsedscrollcontroller.jumpTo(findindex *
              ((findindex * MediaQuery.of(context).size.width * 0.8) + 40));
          ismarktap = false;
        }
      });
      return resultwidget;
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
      onCameraIdle: onCameraIdle,
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
      collapsed: makeCollapsed(),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.57,
              child: googleMap,
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: SearchMapPlaceWidget(
                  apiKey: Preference.kGoogleApiKey,
                  location: initialCameraPosition.target,
                  language: "ko",
                  radius: 30000,
                  onSelected: (place) async {
                    final geolocation = await place.geolocation;
                    googlemap_controller.animateCamera(
                        CameraUpdate.newLatLng(geolocation.coordinates));
                    googlemap_controller.animateCamera(
                        CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                    currentFindAddredss = place.description;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentFindAddredss == null) {
      currentFindAddredss =
          GolobalStateContainer.of(context).state.currentaddress;
    }
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          child: Text(currentFindAddredss),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.78,
          child: makeMainPanel(),
        )
      ],
    ));
  }
}
