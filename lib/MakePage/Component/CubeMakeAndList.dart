import 'package:flutter/material.dart';

class CubeListItem {
  String name;
  IconData icon;
  CubeListItem({this.name, this.icon});
}

class CubeMakeAndList extends StatefulWidget {
  CubeMakeAndList({Key key}) : super(key: key);

  @override
  _CubeMakeAndListState createState() => _CubeMakeAndListState();
}

class _CubeMakeAndListState extends State<CubeMakeAndList> {
  List<CubeListItem> items = new List<CubeListItem>();
  int currentClick = 2;

  @override
  void initState() {
    super.initState();
    items.add(CubeListItem(name: "큐브이름1", icon: Icons.picture_in_picture));
    items.add(CubeListItem(name: "큐브이름2", icon: Icons.picture_in_picture));
    items.add(CubeListItem(name: "큐브이름3", icon: Icons.picture_in_picture));
    items.add(CubeListItem(name: "큐브이름4", icon: Icons.picture_in_picture));
    items.add(CubeListItem(name: "큐브이름5", icon: Icons.picture_in_picture));
    items.add(CubeListItem(name: "큐브이름6", icon: Icons.picture_in_picture));
    items.add(CubeListItem(name: "큐브이름7", icon: Icons.picture_in_picture));
    items.add(CubeListItem(name: "큐브이름8", icon: Icons.picture_in_picture));
    items.add(CubeListItem(name: "큐브이름9", icon: Icons.picture_in_picture));
    items.add(CubeListItem(name: "큐브이름10", icon: Icons.picture_in_picture));
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
              onPressed: () {},
            ),
          )
        ]));
  }
}
