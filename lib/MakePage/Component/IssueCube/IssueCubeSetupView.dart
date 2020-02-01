import 'dart:convert';

import 'package:after_init/after_init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/CubeMakeRichTextEdit.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/IssueCube/IssueCubeDetailPage.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zefyr/zefyr.dart';

class IssueCubeSetupView extends StatefulWidget {
  final Fcube fcube;
  IssueCubeSetupView({Key key, this.fcube}) : super(key: key);

  @override
  _IssueCubeSetupViewState createState() {
    return _IssueCubeSetupViewState(fcube: fcube);
  }
}

class _IssueCubeSetupViewState extends State<IssueCubeSetupView>
    with AfterInitMixin {
  Fcube fcube;

  _IssueCubeSetupViewState({this.fcube});
  Set<Marker> makres = new Set<Marker>();
  CameraPosition initialCameraPosition;

  ScrollController _mainListcontroller = ScrollController();
  GlobalKey<FormState> pageeditfrom = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  CubeRichTextController richTextController;
  bool ismakeing = false;
  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
        target: LatLng(fcube.latitude, fcube.longitude), zoom: 16);
    richTextController = new CubeRichTextController();
    richTextController.isedithint = true;
  }

  @override
  void didInitState() {
    richTextController.ondatacahnge = (value) {
      setState(() {});
    };
    richTextController.ontoolbarshow = () {
      setState(() {
        _mainListcontroller.jumpTo(MediaQuery.of(context).size.height * 0.6);
      });
    };
  }

  void setmakers() async {
    BitmapDescriptor icon = await Fcube.getMarkerImage(fcube.cubeimage, 150);

    setState(() {
      makres.add(Marker(
          markerId: MarkerId("MainCube"),
          icon: icon,
          position: LatLng(fcube.latitude, fcube.longitude)));
    });
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {});
    setmakers();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      initialCameraPosition: initialCameraPosition,
      onMapCreated: onMapCreated,
      markers: makres,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
    );
    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          RaisedButton(
            child: ismakeing ? CircularProgressIndicator() : Text("완료"),
            onPressed: () async {
              if (pageeditfrom.currentState.validate()) {
                setState(() {
                  ismakeing = true;
                });
                fcube.cubename = namecontroller.text;
                Fcubecontent content = new Fcubecontent(
                  contenttype: FcubecontentType.description,
                  contentvalue: json.encode({
                    "description":
                        json.encode(richTextController.document.toJson())
                  }),
                  cubeuuid: fcube.cubeuuid,
                );
                fcube.cubestate = FcubeState.play;
                if (await fcube.makecube() > 0) {
                  if (await content.makecubecontent() > 0) {
                    FcubeExtender1 fcubeextender1 =
                        await FcubeExtender1.getFcubeExtender1(
                            fcube.uid, fcube.cubeuuid);
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return IssueCubeDetailPage(
                          fcubeextender1: fcubeextender1);
                    }));
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  }
                }
                setState(() {
                  ismakeing = false;
                });
              } else {
                setState(() {});
              }
            },
          )
        ]),
        body: Container(
          child: ListView(controller: _mainListcontroller, children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: googleMap,
            ),
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment(-1, 0),
              child: Text(fcube.placeaddress),
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
                      fcube: fcube,
                      parentcontroller: richTextController),
                  Positioned(
                    top: 70,
                    left: 20,
                    child: richTextController.isedithint
                        ? Text("이슈 내용을 입력해 주세요.")
                        : Container(
                            width: 10,
                          ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
