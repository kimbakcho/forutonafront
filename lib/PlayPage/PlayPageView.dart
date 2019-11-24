import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
  Set<Marker> markers;
  bool isloading;
  PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
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
    setMarkers();
    setState(() {});
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
