import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/CubeMakeRichTextEdit.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FQuestCubeDetailCubeSetupView.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zefyr/zefyr.dart';

class FQuestCubePositionSetupView extends StatefulWidget {
  final FcubeQuest fcubeQuest;
  FQuestCubePositionSetupView({Key key, this.fcubeQuest}) : super(key: key);

  @override
  _FQuestCubePositionSetupViewState createState() {
    return _FQuestCubePositionSetupViewState(fcubeQuest);
  }
}

class _FQuestCubePositionSetupViewState
    extends State<FQuestCubePositionSetupView> {
  FcubeQuest fcubeQuest;
  _FQuestCubePositionSetupViewState(this.fcubeQuest);

  CameraPosition initialCameraPosition;

  // GoogleMapController _mapController;
  ScrollController _mainListcontroller = ScrollController();
  Set<Marker> makres = new Set<Marker>();
  GlobalKey<FormState> pageeditfrom = GlobalKey<FormState>();
  TextEditingController namecontroller;
  CubeRichTextController richTextController;

  @override
  void initState() {
    richTextController = new CubeRichTextController();
    richTextController.isedithint = true;
    richTextController.ondatacahnge = (value) {
      setState(() {});
    };
    richTextController.ontoolbarshow = () {
      setState(() {
        _mainListcontroller.jumpTo(MediaQuery.of(context).size.height * 0.6);
      });
    };
    namecontroller = new TextEditingController();
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubeQuest.latitude, fcubeQuest.longitude), zoom: 16);
    super.initState();
  }

  void setmakers() async {
    BitmapDescriptor icon =
        await Fcube.getMarkerImage(fcubeQuest.cubeimage, 150);

    setState(() {
      makres.add(Marker(
          markerId: MarkerId("MainCube"),
          icon: icon,
          position: LatLng(fcubeQuest.latitude, fcubeQuest.longitude)));
    });
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      // _mapController = controller;
    });
    setmakers();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
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
                onPressed: () {
                  if (pageeditfrom.currentState.validate()) {
                    fcubeQuest.cubename = namecontroller.text;
                    fcubeQuest.description =
                        jsonEncode(richTextController.document.toJson());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FQuestCubeDetailCubeSetupView(
                        fcubeQuest: fcubeQuest,
                      );
                    }));
                  } else {
                    setState(() {});
                  }
                },
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
                  child: Form(
                    key: pageeditfrom,
                    child: TextFormField(
                      validator: (value) {
                        if (value.length == 0) {
                          return "제목이 비어 있습니다.";
                        } else {
                          return null;
                        }
                      },
                      controller: namecontroller,
                      decoration: InputDecoration(hintText: "이름을 지어 주세요!."),
                    ),
                  )),
              Container(
                height: 500,
                child: Stack(
                  children: <Widget>[
                    CubeMakeRichTextEdit(
                        zefyrMode: ZefyrMode.edit,
                        custommode: "forutona1",
                        fcube: fcubeQuest,
                        parentcontroller: richTextController),
                    Positioned(
                      top: 70,
                      left: 20,
                      child: richTextController.isedithint
                          ? Text("퀘스트 내용을 입력 하세요")
                          : Container(
                              width: 0,
                            ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
