import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestBottomNaviBar.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestDetailPage.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';

import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:search_map_place/search_map_place.dart';

class MakePageView extends StatefulWidget {
  MakePageView({Key key}) : super(key: key);

  @override
  _MakePageViewState createState() => _MakePageViewState();
}

class _MakePageViewState extends State<MakePageView> {
  ScrollController cubescroller = ScrollController();
  List<String> litems = [];
  bool iseditmode = false;
  FcubeExtender1 currentedititem;

  @override
  void initState() {
    super.initState();
  }

  makeMainViewChioce() {
    if (litems.length == 0) {
      if (GlobalStateContainer.of(context).state.fcubeListUtil.isLoading) {
        return Center(
            child: Container(
                height: 160,
                width: 80,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                          strokeWidth: 3,
                        )),
                    Container(
                      height: 30,
                    ),
                    Text("로딩중")
                  ],
                )));
      }
      if (GlobalStateContainer.of(context).state.fcubeListUtil.cubeList ==
              null ||
          GlobalStateContainer.of(context)
                  .state
                  .fcubeListUtil
                  .cubeList
                  .length ==
              0) {
        return Container(
          child: Center(
            child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                color: Colors.blueAccent,
                dashPattern: [8, 4],
                strokeWidth: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.picture_in_picture,
                          size: 50,
                        ),
                        Container(
                          height: 30,
                        ),
                        Text("제작한 컨텐츠가 없습니다.")
                      ],
                    ),
                  ),
                )),
          ),
        );
      }
      if (GlobalStateContainer.of(context).state.fcubeListUtil.cubeList.length >
          0) {
        return makeCubeListWidget();
      }
    }
  }

  Widget makeCubeListWidget() {
    List<FcubeExtender1> cubes =
        GlobalStateContainer.of(context).state.fcubeListUtil.cubeList;
    return Container(
      margin: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: cubes.length,
        itemBuilder: (cxtx, index) {
          String acttime = DateFormat("yyyy-MM-dd HH:mm:ss")
              .format(cubes[index].activationtime.add(Duration(hours: 9)));
          return Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () async {
                  if (cubes[index].cubetype == FcubeType.questCube) {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings:
                                RouteSettings(name: "FcubeQuestDetailPage"),
                            builder: (context) {
                              return FcubeQuestDetailPage(
                                  fcubeextender1: cubes[index]);
                            }));
                    resetcubeList();
                  }
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: Image(
                            image: AssetImage(
                                'assets/MarkesImages/MessageCube.png'),
                          ),
                        ),
                        Container(width: 10),
                        Expanded(
                          child: Text(cubes[index].cubename),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                          padding: EdgeInsets.all(0),
                          width: 20,
                          height: 20,
                          child: RaisedButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              this.iseditmode = true;
                              this.currentedititem = cubes[index];
                              setState(() {});
                            },
                            child: Icon(
                              Icons.apps,
                              size: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 60,
                        ),
                        Expanded(
                          child: Container(
                            child: Text(cubes[index].placeaddress == null
                                ? ""
                                : cubes[index].placeaddress),
                          ),
                        ),
                        Container(
                          child: Text(
                              "${cubes[index].distancewithme.roundToDouble()} m"),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 60,
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Text(cubes[index].nickname),
                            )),
                        Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(DateFormat("yyyy-MM-dd HH:mm:ss")
                                  .format(DateTime.parse(cubes[index].maketime)
                                      .add(Duration(hours: 9)))),
                              //
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 60,
                        ),
                        Container(
                          child: Text("${cubes[index].pointreward}"),
                        ),
                        Container(
                          width: 60,
                        ),
                        Container(
                          child: Text("${cubes[index].influencereward}"),
                        ),
                        Container(
                          width: 60,
                        ),
                        Container(
                          width: 150,
                          padding: EdgeInsets.only(right: 20),
                          child: Text("$acttime"),
                        )
                      ],
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }

  Future<bool> _asyncConfirmDeletecubeDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('정말로 삭제 하시겠습니까?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: const Text('삭제'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }

  resetcubeList() async {
    GlobalStateContainer.of(context).resetcubeListUtilcubeList();
    GlobalStateContainer.of(context).setfcubeListUtilisLoading(true);
    GlobalStateContainer.of(context).addfcubeListUtilcubeList(
        await FcubeExtender1.getusercubes(offset: 0, limit: 10));
    Position currentposition =
        GlobalStateContainer.of(context).state.currentposition;
    GlobalStateContainer.of(context)
        .updateCubeListupdatedistancewithme(currentposition);
    GlobalStateContainer.of(context).setfcubeListUtilisLoading(false);
  }

  Widget _selectbottomNavigationBar() {
    if (iseditmode == true) {
      if (this.currentedititem.cubetype == FcubeType.questCube) {
        return FcubeQuestBottomNaviBar(
          fcube: currentedititem,
          onfuntionclick: (value) {
            setState(() {});
          },
        );
      }
    } else {
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _selectbottomNavigationBar(),
      floatingActionButton: Container(
        child: FloatingActionButton(
          onPressed: () async {
            Map<PermissionGroup, PermissionStatus> permissition =
                await PermissionHandler().requestPermissions(
                    [PermissionGroup.location, PermissionGroup.locationAlways]);
            if ((permissition[PermissionGroup.location] ==
                    PermissionStatus.granted) &&
                (permissition[PermissionGroup.locationAlways] ==
                    PermissionStatus.granted)) {
              await Navigator.pushNamed(context, "/SelectSwipeCubeView");
              resetcubeList();
            } else {
              SnackBar snak = new SnackBar(
                content: Text("다시 한번 버튼을 눌러 주세요."),
                duration: Duration(seconds: 1),
              );
              Scaffold.of(context).showSnackBar(snak);
            }
          },
          child: Icon(Icons.add),
        ),
      ),
      body: Container(
          decoration: iseditmode ? BoxDecoration(color: Colors.grey) : null,
          child: GestureDetector(
            child: makeMainViewChioce(),
            onTap: () {
              this.iseditmode = false;
              setState(() {});
            },
          )),
    );
  }
}
