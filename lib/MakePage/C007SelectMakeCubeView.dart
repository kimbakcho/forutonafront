import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/C003GoogleMapMakeView.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:uuid/uuid.dart';

class C007SelectMakeCubeView extends StatefulWidget {
  C007SelectMakeCubeView({Key key}) : super(key: key);

  @override
  _C007SelectMakeCubeViewState createState() => _C007SelectMakeCubeViewState();
}

class _C007SelectMakeCubeViewState extends State<C007SelectMakeCubeView> {
  Uuid uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("큐브 선택하기",
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xff454f63),
            )),
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Fcube fcube = new Fcube();
                fcube.cubeuuid = uuid.v4();
                fcube.cubetype = FcubeType.issuecube;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return C003GoogleMapMakeView(selectFcube: fcube);
                }));
              },
              child: Card(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 62,
                        decoration: BoxDecoration(
                          color: Color(0xffF9E3E3),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/MainImage/photographer-5551_640.png"),
                              fit: BoxFit.cover),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: 30,
                              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              padding: EdgeInsets.only(left: 2),
                              child: Icon(
                                ForutonaIcon.issue,
                                color: Colors.white,
                                size: 18,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffDC3E57)),
                            ),
                            Container(
                                child: Text("이슈 큐브",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Color(0xff454f63),
                                    )))
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "실제 세상에서 일어나는 크고 작은 소식들을 지도 위에 \n표시하고 공유할 수 있어요.",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Color(0xff708491),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  )),
            ),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Fcube fcube = new Fcube();
                fcube.cubeuuid = uuid.v4();
                fcube.cubetype = FcubeType.questCube;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return C003GoogleMapMakeView(selectFcube: fcube);
                }));
              },
              child: Card(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 62,
                        decoration: BoxDecoration(
                          color: Color(0xffE5EAFF),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/MainImage/adult-1850181_1920.png"),
                              fit: BoxFit.cover),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: 30,
                              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              padding: EdgeInsets.only(left: 2),
                              child: Icon(
                                ForutonaIcon.quest,
                                color: Colors.white,
                                size: 15,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff4F72FF)),
                            ),
                            Container(
                                child: Text("퀘스트 큐브",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Color(0xff454f63),
                                    )))
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "현실에서 해결해야할 임무가 있으신가요? 보상을 건 퀘스\n트를 만들어 세상에 도움을 청해보세요.",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Color(0xff708491),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
