import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FCubeGeoSearchUtil.dart';
import 'package:forutonafront/Common/GeoSearchUtil.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/globals.dart';
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
  List<FcubeExtender1> currentvisualfcube = List<FcubeExtender1>();
  List<LatLngAndGeohash> currentvisualPoints = List();
  ClusteringHelper clusteringHelper;
  @override
  void initState() {
    super.initState();
    clusteringHelper = ClusteringHelper.forMemory(
      list: currentvisualPoints,
      updateMarkers: updateMarkers,
      aggregationSetup: AggregationSetup(markerSize: 150),
    );
    initgeolocation();
  }

  initgeolocation() async {
    isloading = true;
    initposition = await geolocation.getCurrentPosition();
    initialCameraPosition = new CameraPosition(
        target: LatLng(initposition.latitude, initposition.longitude),
        zoom: 16);
    isloading = false;
    setState(() {});
  }

  void onMapCreated(GoogleMapController controller) async {
    googlemap_controller = controller;
    clusteringHelper.mapController = controller;
    initMemoryClustering();
    setMarkers();
    setState(() {});
  }

  initMemoryClustering() async {
    LatLngBounds visibleGegion = await googlemap_controller.getVisibleRegion();
    double distance = await geolocation.distanceBetween(
        initialCameraPosition.target.latitude,
        initialCameraPosition.target.longitude,
        visibleGegion.northeast.latitude,
        visibleGegion.northeast.longitude);

    FCubeGeoSearchUtil searchitem = FCubeGeoSearchUtil.fromGeoSearchUtil(
        GeoSearchUtil(
            distance: distance,
            latitude: initialCameraPosition.target.latitude,
            longitude: initialCameraPosition.target.longitude,
            limit: 100,
            offset: 0),
        cubescope: 0,
        cubestate: 1,
        activationtime: DateTime.now());
    currentvisualfcube = await FcubeExtender1.findNearDistanceCube(searchitem);
    for (int i = 0; i < currentvisualfcube.length; i++) {
      currentvisualPoints.add(LatLngAndGeohash(
        LatLng(currentvisualfcube[i].latitude, currentvisualfcube[i].longitude),
      ));
    }
    clusteringHelper.list = currentvisualPoints;
    clusteringHelper.onCameraMove(initialCameraPosition);
    clusteringHelper.updateMap();
  }

  updateMarkers(Set<Marker> markers) {
    setState(() {
      this.markers = markers;
    });
  }

  //해당 부분 Backend 에서 추후 Asnyc 처리 필요할것으로 예상
  onPanelCameraMove(CameraPosition cameraPosition) async {
    print(cameraPosition.zoom);
    print(cameraPosition.target.toString());
    LatLngBounds visibleGegion = await googlemap_controller.getVisibleRegion();
    double distance = await geolocation.distanceBetween(
        cameraPosition.target.latitude,
        cameraPosition.target.longitude,
        visibleGegion.northeast.latitude,
        visibleGegion.northeast.longitude);
    print("${distance} M");

    FCubeGeoSearchUtil searchitem = FCubeGeoSearchUtil.fromGeoSearchUtil(
        GeoSearchUtil(
            distance: distance,
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude,
            limit: 100,
            offset: 0),
        cubescope: 0,
        cubestate: 1,
        activationtime: DateTime.now());
    currentvisualfcube = await FcubeExtender1.findNearDistanceCube(searchitem);
    currentvisualPoints.clear();
    for (int i = 0; i < currentvisualfcube.length; i++) {
      currentvisualPoints.add(LatLngAndGeohash(
        LatLng(currentvisualfcube[i].latitude, currentvisualfcube[i].longitude),
      ));
    }
    clusteringHelper.list = currentvisualPoints;
    clusteringHelper.onCameraMove(cameraPosition);
    clusteringHelper.updateMap();
  }

  //setinit markes
  setMarkers() async {}

  Widget makeMainPanel() {
    final GoogleMap googleMap = GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      initialCameraPosition: initialCameraPosition,
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                      height: 150,
                      margin: EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Text("${index}"));
                },
              ),
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
          child: isloading ? CircularProgressIndicator() : makeMainPanel(),
        )
      ],
    ));
  }
}
