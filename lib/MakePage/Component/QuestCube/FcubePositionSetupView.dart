import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/CustomImageDelegate%20.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class FcubePositionSetupView extends StatefulWidget {
  final FcubeQuest fcubeQuest;
  FcubePositionSetupView({Key key, this.fcubeQuest}) : super(key: key);

  @override
  _FcubePositionSetupViewState createState() {
    return _FcubePositionSetupViewState(fcubeQuest);
  }
}

class _FcubePositionSetupViewState extends State<FcubePositionSetupView> {
  FcubeQuest fcubeQuest;
  _FcubePositionSetupViewState(this.fcubeQuest);

  CameraPosition initialCameraPosition;
  GoogleMapController _mapController;

  NotusDocument document;
  ZefyrController _wigcontroller;
  FocusNode _focusNode;

  ScrollController _mainListcontroller = ScrollController();

  Set<Marker> makres = new Set<Marker>();

  bool isedithint = true;

  @override
  void initState() {
    // TODO: implement initState
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubeQuest.latitude, fcubeQuest.longitude), zoom: 16);

    super.initState();

    document = _loadDocument();
    setState(() {
      _wigcontroller = ZefyrController(document);

      _focusNode = FocusNode();
    });
    document.changes.listen((data) {
      print(document.length);
      if (document.length > 0) {
        isedithint = false;
        setState(() {});
      } else {
        isedithint = true;
        setState(() {});
      }
    });
  }

  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)

    return NotusDocument();
  }

  void setmakers() async {
    BitmapDescriptor icon =
        await Fcube.getMarkerImage("assets/MarkesImages/QuestCube.png", 150);

    setState(() {
      makres.add(Marker(
          markerId: MarkerId("MainCube"),
          icon: icon,
          position: LatLng(fcubeQuest.latitude, fcubeQuest.longitude)));
    });
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      _mapController = controller;
    });
    setmakers();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      gestureRecognizers: Set()
        ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
        ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
        ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
        ..add(Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer())),
      initialCameraPosition: initialCameraPosition,
      onMapCreated: onMapCreated,
      markers: makres,
    );
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {},
                child: Text("다음"),
              ),
            )
          ],
        ),
        body: Container(
          child: ListView(
            controller: _mainListcontroller,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: googleMap,
              ),
              Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment(-1, 0),
                child: Text(fcubeQuest.placeaddress),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment(-1, 0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "이름을 지어 주세요!."),
                  )),
              Container(
                height: 500,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 70,
                      left: 20,
                      child: isedithint
                          ? Text("퀘스트 내용을 입력 하세요")
                          : Container(
                              width: 0,
                            ),
                    ),
                    ZefyrScaffold(
                      child: ZefyrEditor(
                        custommode: "forutona1",
                        autofocus: false,
                        padding: EdgeInsets.all(16),
                        imageDelegate: CustomImageDelegate(),
                        controller: _wigcontroller,
                        focusNode: _focusNode,
                        ontoolbarshow: () {
                          _mainListcontroller
                              .jumpTo(MediaQuery.of(context).size.height * 0.5);
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
