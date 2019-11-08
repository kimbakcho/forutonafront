import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/FcubeMakeDetail1View.dart';
import 'package:geolocator/geolocator.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:uuid/uuid.dart';

class FcubeListItem {
  String type;
  String name;
  IconData icon;
  FcubeListItem({this.type, this.name, this.icon});
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
    items.add(FcubeListItem(
        type: "MeessageBox", name: "메세제 박스", icon: Icons.picture_in_picture));
    items.add(FcubeListItem(
        type: "큐브타입2", name: "메세제 박스1", icon: Icons.picture_in_picture));
    items.add(FcubeListItem(
        type: "큐브타입3", name: "메세제 박스1", icon: Icons.picture_in_picture));
    items.add(FcubeListItem(
        type: "큐브타입4", name: "메세제 박스1", icon: Icons.picture_in_picture));
    items.add(FcubeListItem(
        type: "큐브타입5", name: "메세제 박스1", icon: Icons.picture_in_picture));
    items.add(FcubeListItem(
        type: "큐브타입6", name: "메세제 박스1", icon: Icons.picture_in_picture));
    items.add(FcubeListItem(
        type: "큐브타입7", name: "메세제 박스1", icon: Icons.picture_in_picture));
    items.add(FcubeListItem(
        type: "큐브타입8", name: "메세제 박스1", icon: Icons.picture_in_picture));
    items.add(FcubeListItem(
        type: "큐브타입9", name: "메세제 박스1", icon: Icons.picture_in_picture));
    items.add(FcubeListItem(
        type: "큐브타입10", name: "메세제 박스1", icon: Icons.picture_in_picture));
    selectionFcube.cubetype = items[currentClick].type;
  }

  void selectPushNavi(context) async {
    if (selectionFcube.cubetype == "MeessageBox") {
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FcubeMakeDetail1View(
          selectionfcube: selectionFcube,
        );
      }));

      selectionFcube.cubeuuid = uuid.v4();
      selectionFcube.cubename =
          selectionFcube.cubetype = items[currentClick].type;
      this.widget.onretrunnavi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.25,
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
                          placeaddress[0].subThoroughfare;
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
