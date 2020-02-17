import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ID001CubeDetailPage extends StatefulWidget {
  final FcubeExtender1 fcubeextender1;
  ID001CubeDetailPage({@required this.fcubeextender1, Key key})
      : super(key: key);

  @override
  _ID001CubeDetailPageState createState() {
    return _ID001CubeDetailPageState(this.fcubeextender1);
  }
}

class _ID001CubeDetailPageState extends State<ID001CubeDetailPage> {
  _ID001CubeDetailPageState(this.fcubeextender1);
  FcubeExtender1 fcubeextender1;
  CameraPosition initialCameraPosition;
  GoogleMapController mapController;
  Set<Marker> markers;

  @override
  void initState() {
    super.initState();
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubeextender1.latitude, fcubeextender1.longitude),
        zoom: 16);
    markers = Set<Marker>();
    markers.add(new Marker(
        markerId: MarkerId("test"),
        position: LatLng(fcubeextender1.latitude, fcubeextender1.longitude)));
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
        onTap: (LatLng lat) {
          print("tap1");
        },
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: markers,
        initialCameraPosition: initialCameraPosition);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(ForutonaIcon.share),
          ),
          IconButton(
            icon: Icon(ForutonaIcon.setting),
          ),
        ],
        title: Container(
            child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 2),
              height: 35.00,
              width: 35.00,
              child: Icon(
                ForutonaIcon.issue,
                size: 20,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                color: Color(0xffdc3e57),
                border: Border.all(
                  width: 1.00,
                  color: Color(0xffdc3e57),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.16),
                    blurRadius: 6,
                  ),
                ],
                shape: BoxShape.circle,
              ),
            )
          ],
        )),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            child: ListView(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Stack(
                      children: <Widget>[
                        googleMap,
                        GestureDetector(
                            onTap: () {
                              print("tap");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.white.withOpacity(0.8),
                                    Colors.white.withOpacity(0)
                                  ])),
                            )),
                        Positioned(
                            top: 0,
                            child: Container(
                                margin: EdgeInsets.only(left: 16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          child: Text("이슈볼",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: "Noto Sans CJK KR",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                color: Color(0xffff4f9a),
                                              ))),
                                      Container(
                                          child: Text(fcubeextender1.cubename,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: "Noto Sans CJK KR",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                                color: Color(0xff454f63),
                                              ))),
                                      Container(
                                          child: Row(children: <Widget>[
                                        Container(
                                          child: Icon(
                                            ForutonaIcon.visibility,
                                            color: Color(0xff78849E),
                                            size: 20,
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                                "${fcubeextender1.cubehits}",
                                                style: TextStyle(
                                                  fontFamily: "Gibson",
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Color(0xff78849e),
                                                )))
                                      ]))
                                    ])))
                      ],
                    )),
                MakerPanel(fcubeextender1: fcubeextender1),
                SizedBox(
                  height: 16,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 4.00),
                        color: Color(0xff455b63).withOpacity(0.08),
                        blurRadius: 16,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12.00),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 42.00,
                        width: 42.00,
                        child: Icon(Icons.location_on),
                        decoration: BoxDecoration(
                          color: Color(0xffe4e7e8),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.00, 12.00),
                              color: Color(0xff455b63).withOpacity(0.10),
                              blurRadius: 16,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20.00),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("설치 장소",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xff454f63),
                                    )),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.68,
                                    child:
                                        Text("${fcubeextender1.placeaddress}",
                                            softWrap: true,
                                            style: TextStyle(
                                              fontFamily: "Noto Sans CJK KR",
                                              fontSize: 14,
                                              color: Color(0xff78849e),
                                            )))
                              ]))
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  child: (Text("123123")),
                ),
                Container(
                  height: 300,
                  child: (Text("123123")),
                ),
                Container(
                  height: 300,
                  child: (Text("123123")),
                ),
                Container(
                  height: 300,
                  child: (Text("123123")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MakerPanel extends StatelessWidget {
  const MakerPanel({
    Key key,
    @required this.fcubeextender1,
  }) : super(key: key);

  final FcubeExtender1 fcubeextender1;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 105,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 4.00),
              color: Color(0xff455b63).withOpacity(0.08),
              blurRadius: 16,
            ),
          ],
          borderRadius: BorderRadius.circular(12.00),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text("메이커",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xff454f63),
                    )),
              ),
              Container(
                  child: Row(children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  height: 41.00,
                  width: 41.00,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(fcubeextender1.profilepicktureurl),
                    ),
                    borderRadius: BorderRadius.circular(50.00),
                  ),
                ),
                Expanded(
                    child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                      Text(fcubeextender1.nickname,
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff78849e),
                          )),
                      Text("팔로워 ${fcubeextender1.followcount}",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Color(0xffb1b1b1),
                          )),
                    ]))),
                Container(
                    height: 30.00,
                    width: 30.00,
                    child: FlatButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                    decoration: BoxDecoration(
                      color: Color(0xff78849e),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                          blurRadius: 6,
                        )
                      ],
                      shape: BoxShape.circle,
                    )),
                SizedBox(
                  width: 16,
                )
              ]))
            ]));
  }
}
