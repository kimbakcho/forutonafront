import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/GoogleMapsMakeView.dart';
import 'package:permission_handler/permission_handler.dart';

class MakePageView extends StatefulWidget {
  MakePageView({Key key}) : super(key: key);

  @override
  _MakePageViewState createState() => _MakePageViewState();
}

class _MakePageViewState extends State<MakePageView> {
  List<String> litems = [];
  @override
  void initState() {
    super.initState();
  }

  makeMainViewChioce() {
    if (litems.length == 0) {
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
    } else {}
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
