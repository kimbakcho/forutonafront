import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FcubeExtenderMarkerGenerator.dart';
import 'package:forutonafront/Common/FcubeTagSearch.dart';
import 'package:forutonafront/Common/Fcubetagextender1.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/IssueCube/ID001CubeDetailPage.dart';
import 'package:forutonafront/globals.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class TagsRecomandWidget extends StatefulWidget {
  TagsRecomandWidget({this.tagsController, Key key}) : super(key: key);
  final TagsController tagsController;

  @override
  _TagsRecomandWidgetState createState() {
    return _TagsRecomandWidgetState(tagsController: tagsController);
  }
}

class _TagsRecomandWidgetState extends State<TagsRecomandWidget>
    with AfterLayoutMixin {
  _TagsRecomandWidgetState({this.tagsController});
  TagsController tagsController;
  FcubetagSearch tagsearch = FcubetagSearch(limit: 4, offset: 0);
  bool isloading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    ontoptap(0);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> taglistWidget = List<Widget>();
    tagsController.currentFcubelist.forEach((item) {
      item.distancewithme = GreatCircleDistance.fromDegrees(
              latitude1: item.latitude,
              longitude1: item.longitude,
              latitude2: GlobalStateContainer.of(context)
                  .state
                  .currentposition
                  .latitude,
              longitude2: GlobalStateContainer.of(context)
                  .state
                  .currentposition
                  .longitude)
          .haversineDistance();

      taglistWidget.add(Container(
        margin: EdgeInsets.all(4),
        height: 168.00,
        width: MediaQuery.of(context).size.width * 0.45,
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () async {
            isloading = true;
            setState(() {});
            FcubeExtender1 fcubeExtender1 =
                await FcubeExtender1.getFcubeExtender1(item.cubeuuid);
            isloading = false;
            setState(() {});
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ID001CubeDetailPage(
                  fcubeextender1: fcubeExtender1, initmodifyflag: false);
            }));
          },
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      height: 87.00,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          image: item.description.desimages.length > 0
                              ? DecorationImage(
                                  image: NetworkImage(
                                      item.description.desimages[0].src),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: AssetImage(
                                      "assets/MainImage/fantasy-1.png"),
                                  fit: BoxFit.fitWidth),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.00),
                            topRight: Radius.circular(12.00),
                          ))),
                  Container(
                    margin: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(item.cubeName,
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xff454f63),
                        )),
                  )
                ],
              ),
              Positioned(
                  left: 8,
                  bottom: 8,
                  child: Text(Fcube.fcubeTypeToStrChange(item.cubeType),
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 10,
                        color: Color(0xffff4f9a),
                      ))),
              Positioned(
                  bottom: 8,
                  right: 8,
                  child: Text(
                      "${(item.distancewithme / 1000).toStringAsFixed(1)} km",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 10,
                        color: Color(0xff78849e),
                      )))
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 3.00),
              color: Color(0xff000000).withOpacity(0.16),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(12.00),
        ),
      ));
    });

    return Stack(
      children: <Widget>[
        Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(children: <Widget>[
              Container(
                height: 40,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: tagsController.taglists.length,
                    itemBuilder: (context, index) {
                      if (index == tagsController.currentindex) {
                        return Container(
                            margin: EdgeInsets.fromLTRB(16, 10, 0, 10),
                            child: InkWell(
                              onTap: () {
                                ontoptap(index);
                              },
                              child: Text("#${tagsController.taglists[index]}",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xff454f63),
                                  )),
                            ));
                      } else {
                        return Container(
                            margin: EdgeInsets.fromLTRB(16, 10, 0, 10),
                            child: InkWell(
                              onTap: () {
                                ontoptap(index);
                              },
                              child: Text(tagsController.taglists[index],
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xffe4e7e8),
                                  )),
                            ));
                      }
                    }),
              ),
              Container(
                  child: Wrap(
                children: taglistWidget,
              ))
            ])),
        isloading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.withOpacity(0.5),
                child: Center(
                    child: Container(
                  height: 100,
                  width: 100,
                  child: Loading(
                      indicator: BallScaleIndicator(),
                      size: 50.0,
                      color: Theme.of(context).accentColor),
                )),
              )
            : Container()
      ],
    );
  }

  ontoptap(int index) async {
    this.isloading = true;
    setState(() {});
    tagsController.currentindex = index;
    tagsController.onchangeindex(tagsController.currentindex);
    tagsController.currenttag = tagsController.taglists[index];
    tagsController.onchangetag(tagsController.currenttag);
    tagsearch.limit = 4;
    tagsearch.offset = 0;
    tagsearch.tagitem = tagsController.currenttag;
    if (tagsController.currentFcubelist != null) {
      tagsController.currentFcubelist.clear();
    } else {
      tagsController.currentFcubelist = List<Fcubetagextender1>();
    }
    tagsController.currentFcubelist
        .addAll(await Fcubetagextender1.getFcubetagSearch(tagsearch));
    this.isloading = false;
    setState(() {});
    tagsController.onLoadingfinish(tagsController.currentFcubelist);
  }
}

class TagsController {
  int currentindex;
  List<String> taglists;
  String currenttag;
  List<Fcubetagextender1> currentFcubelist = List<Fcubetagextender1>();
  Function(int) onchangeindex = (value) {};
  Function(String) onchangetag = (value) {};
  Function(List<Fcubetagextender1>) onLoadingfinish = (value) {};
  TagsController() {
    currentindex = 0;
  }
}
