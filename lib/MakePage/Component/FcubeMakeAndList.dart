import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FQuestCubePositionSetupView.dart';

import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/FcubeMakeDetail1View.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

class FcubeListItem {
  String type;
  String name;
  IconData icon;
  String description = "";
  FcubeListItem({this.type, this.name, this.icon, this.description});
}

class FcubeMakeAndList extends StatefulWidget {
  final Fcube selectionFcube;
  final Function onretrunnavi;
  FcubeMakeAndList({Key key, this.selectionFcube, this.onretrunnavi})
      : super(key: key);

  @override
  _FcubeMakeAndListState createState() {
    return _FcubeMakeAndListState(selectionFcube: selectionFcube);
  }
}

class _FcubeMakeAndListState extends State<FcubeMakeAndList> {
  _FcubeMakeAndListState({this.selectionFcube});
  Fcube selectionFcube;
  List<FcubeListItem> items = new List<FcubeListItem>();
  int currentClick = 0;
  Uuid uuid = Uuid();
  @override
  void initState() {
    super.initState();
  }

  void selectPushNavi(context) async {
    if (selectionFcube.cubetype == FcubeType.messageCube) {
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FcubeMakeDetail1View(
          selectionfcube: selectionFcube,
        );
      }));

      selectionFcube.cubeuuid = uuid.v4();
      selectionFcube.cubename =
          selectionFcube.cubetype = items[currentClick].type;
      this.widget.onretrunnavi();
    } else if (selectionFcube.cubetype == FcubeType.questCube) {
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FQuestCubePositionSetupView(
          fcubeQuest: new FcubeQuest(cube: selectionFcube),
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Color(0xADA3A37D)),
        child: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.14,
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.fromLTRB(
                      0,
                      currentClick == index ? 0 : 10,
                      0,
                      currentClick == index ? 0 : 10),
                  width: currentClick == index ? 100 : 50,
                  // padding: EdgeInsets.all(currentClick == index ? 0 : 10),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black)),
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      (items[index].icon),
                      size: currentClick == index ? 50 : 30,
                    ),
                    onPressed: () {
                      currentClick = index;
                      selectionFcube.cubetype = items[currentClick].type;
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            child: Text(items[currentClick].name),
          ),
          Container(
            child: Text(items[currentClick].description),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: RaisedButton(
              child: Text("Make"),
              onPressed: () async {
                List<Placemark> placeaddress = await Geolocator()
                    .placemarkFromCoordinates(
                        selectionFcube.latitude, selectionFcube.longitude,
                        localeIdentifier: "ko");
                if (placeaddress.length > 0) {
                  selectionFcube.country = placeaddress[0].country;
                  selectionFcube.administrativearea =
                      placeaddress[0].administrativeArea;
                  selectionFcube.placeaddress =
                      placeaddress[0].administrativeArea +
                          " " +
                          placeaddress[0].thoroughfare +
                          " " +
                          placeaddress[0].subThoroughfare +
                          placeaddress[0].name;
                } else {
                  selectionFcube.placeaddress =
                      selectionFcube.latitude.toStringAsFixed(2) +
                          "," +
                          selectionFcube.longitude.toStringAsFixed(2);
                }
                selectPushNavi(context);
              },
            ),
          )
        ]));
  }
}
