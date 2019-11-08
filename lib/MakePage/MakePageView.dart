import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/GoogleMapsMakeView.dart';
import 'package:forutonafront/globals.dart';
import 'package:permission_handler/permission_handler.dart';

class MakePageView extends StatefulWidget {
  MakePageView({Key key}) : super(key: key);

  @override
  _MakePageViewState createState() => _MakePageViewState();
}

class _MakePageViewState extends State<MakePageView> {
  ScrollController cubescroller = ScrollController();
  List<String> litems = [];
  @override
  void initState() {
    super.initState();
  }

  makeMainViewChioce() {
    if (litems.length == 0) {
      if (GolobalStateContainer.of(context).state.fcubeListUtil.isLoading) {
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
      if (GolobalStateContainer.of(context).state.fcubeListUtil.cubeList ==
              null ||
          GolobalStateContainer.of(context)
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
      if (GolobalStateContainer.of(context)
              .state
              .fcubeListUtil
              .cubeList
              .length >
          0) {
        return makeCubeListWidget();
      }
    }
  }

  Widget makeCubeListWidget() {
    return Container(
      margin: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: GolobalStateContainer.of(context)
            .state
            .fcubeListUtil
            .cubeList
            .length,
        itemBuilder: (cxtx, index) {
          return Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        child: Image(
                          image:
                              AssetImage('assets/MarkesImages/MessageCube.png'),
                        ),
                      ),
                      Container(width: 10),
                      Expanded(
                        child: Text(GolobalStateContainer.of(context)
                            .state
                            .fcubeListUtil
                            .cubeList[index]
                            .cubename),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                        padding: EdgeInsets.all(0),
                        width: 20,
                        height: 20,
                        child: RaisedButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
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
                          child: Text(GolobalStateContainer.of(context)
                                      .state
                                      .fcubeListUtil
                                      .cubeList[index]
                                      .placeaddress ==
                                  null
                              ? ""
                              : GolobalStateContainer.of(context)
                                  .state
                                  .fcubeListUtil
                                  .cubeList[index]
                                  .placeaddress),
                        ),
                      )
                    ],
                  )
                ],
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      children: [
        makeMainViewChioce(),
        Positioned(
          bottom: 15,
          right: 0,
          child: RaisedButton(
            padding: EdgeInsets.all(7),
            shape: CircleBorder(),
            child: Icon(
              Icons.control_point_duplicate,
              size: 50,
            ),
            onPressed: () async {
              Map<PermissionGroup, PermissionStatus> permissition =
                  await PermissionHandler().requestPermissions([
                PermissionGroup.location,
                PermissionGroup.locationAlways
              ]);
              if ((permissition[PermissionGroup.location] ==
                      PermissionStatus.granted) &&
                  (permissition[PermissionGroup.locationAlways] ==
                      PermissionStatus.granted)) {
                Navigator.pushNamed(context, "/GoogleMapsMakeView");
              } else {
                SnackBar snak = new SnackBar(
                  content: Text("다시 한번 버튼을 눌러 주세요."),
                  duration: Duration(seconds: 1),
                );
                Scaffold.of(context).showSnackBar(snak);
              }
            },
          ),
        )
      ],
    );
  }
}
