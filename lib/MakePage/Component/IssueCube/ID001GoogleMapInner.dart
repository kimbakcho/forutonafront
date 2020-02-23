import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/marker_generator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';

class ID001GoogleMapInner extends StatefulWidget {
  ID001GoogleMapInner({this.fcubeExtender1, Key key}) : super(key: key);
  final FcubeExtender1 fcubeExtender1;

  @override
  _ID001GoogleMapInnerState createState() {
    return _ID001GoogleMapInnerState(fcubeExtender1: fcubeExtender1);
  }
}

class _ID001GoogleMapInnerState extends State<ID001GoogleMapInner> {
  _ID001GoogleMapInnerState({this.fcubeExtender1});
  FcubeExtender1 fcubeExtender1;
  GoogleMapController mapController;
  Set<Marker> markers = Set<Marker>();
  Map<FcubeType, Uint8List> markeritem = Map<FcubeType, Uint8List>();
  CameraPosition initialCameraPosition;
  bool isinitposition = true;

  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
        target: LatLng(fcubeExtender1.latitude, fcubeExtender1.longitude),
        zoom: 16);
    List<Widget> markerwidget = List<Widget>();
    markerwidget.add(getMakerWidget(FcubeType.questCube));
    markerwidget.add(getMakerWidget(FcubeType.issuecube));
    MarkerGenerator(markerwidget, (bitmaps) {
      bitmaps.asMap().forEach((i, bmp) {
        if (i == 0) {
          markeritem[FcubeType.questCube] = bmp;
        } else if (i == 1) {
          markeritem[FcubeType.issuecube] = bmp;
        }
      });
      initMakers();
    }).generate(context);
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      markers: markers,
      initialCameraPosition: initialCameraPosition,
      onCameraMove: (position) {
        double adistance = GreatCircleDistance.fromDegrees(
                latitude1: fcubeExtender1.latitude,
                longitude1: fcubeExtender1.longitude,
                latitude2: position.target.latitude,
                longitude2: position.target.longitude)
            .haversineDistance();

        if (adistance < 1.0) {
          isinitposition = true;
        } else {
          isinitposition = false;
        }

        setState(() {});
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: Container(
          child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        title: Container(
            child: Text("위치",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
      ),
      body: Stack(children: <Widget>[
        googleMap,
        Positioned(
            top: 16,
            right: 16,
            child: Container(
                child: FlatButton(
                  child: Icon(ForutonaIcon.path),
                  onPressed: () async {
                    Position currentposition = await Geolocator()
                        .getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(currentposition.latitude,
                                currentposition.longitude),
                            zoom: 16)));
                  },
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
                ))),
        Positioned(
          bottom: 0,
          child: Container(
              padding: EdgeInsets.all(0),
              child: isinitposition
                  ? FlatButton(
                      onPressed: () {},
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("${fcubeExtender1.placeaddress}",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 12,
                                  color: Color(0xff454f63),
                                )),
                            Text("이슈볼이 설치된 위치로 이동합니다.",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xffb1b1b1),
                                ))
                          ],
                        ),
                      ))
                  : FlatButton(
                      onPressed: () async {
                        await mapController.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(fcubeExtender1.latitude,
                                    fcubeExtender1.longitude),
                                zoom: 16)));
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("${fcubeExtender1.placeaddress}",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 12,
                                  color: Color(0xff454f63),
                                )),
                            Text("이슈볼이 설치된 위치로 이동합니다.",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xffff4f9a),
                                ))
                          ],
                        ),
                      )),
              color: Color(0xffffffff).withOpacity(0.70),
              height: 77,
              width: MediaQuery.of(context).size.width),
        )
      ]),
    );
  }

  initMakers() {
    markers.add(new Marker(
        anchor: Offset(0.5, 0.5),
        markerId: MarkerId(fcubeExtender1.cubeuuid),
        icon: BitmapDescriptor.fromBytes(markeritem[fcubeExtender1.cubetype]),
        position: LatLng(fcubeExtender1.latitude, fcubeExtender1.longitude)));
    setState(() {});
  }

  Widget getMakerWidget(FcubeType cubetype) {
    if (cubetype == FcubeType.questCube) {
      return Container(
          alignment: Alignment.center,
          child: Container(
            height: 35.00,
            width: 35.00,
            decoration: BoxDecoration(
              color: Color(0xff4f72ff),
              shape: BoxShape.circle,
            ),
            child: Icon(
              ForutonaIcon.quest,
              size: 20,
              color: Colors.white,
            ),
          ),
          height: 92.00,
          width: 92.00,
          decoration: BoxDecoration(
            color: Color(0xff39f999).withOpacity(0.17),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff321636).withOpacity(0.04),
                blurRadius: 12,
              ),
            ],
            shape: BoxShape.circle,
          ));
    } else if (cubetype == FcubeType.issuecube) {
      return Container(
          alignment: Alignment.center,
          child: Container(
            height: 35.00,
            width: 35.00,
            padding: EdgeInsets.only(left: 3),
            decoration: BoxDecoration(
              color: Color(0xffdc3e57),
              shape: BoxShape.circle,
            ),
            child: Icon(
              ForutonaIcon.issue,
              size: 20,
              color: Colors.white,
            ),
          ),
          height: 92.00,
          width: 92.00,
          decoration: BoxDecoration(
            color: Color(0xff39f999).withOpacity(0.17),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff321636).withOpacity(0.04),
                blurRadius: 12,
              ),
            ],
            shape: BoxShape.circle,
          ));
    } else {
      return Container();
    }
  }
}
