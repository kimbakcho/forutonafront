import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/HCodePage/H002/H002PageViewModel.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class H002Page extends StatelessWidget {
  String heroTag;

  H002Page({this.heroTag});

  @override
  Widget build(BuildContext context) {
    //Hero Animation Speed
    timeDilation = 1.5;
    return ChangeNotifierProvider(
        create: (_) => H002PageViewModel(context),
        child: Consumer<H002PageViewModel>(builder: (_, model, child) {
          return Hero(
              tag: this.heroTag,
              child: Stack(children: <Widget>[
                Scaffold(
                    body: Container(
                        margin: EdgeInsets.fromLTRB(0, 22, 0, 0),
                        child: Stack(children: <Widget>[
                          Column(
                            children: <Widget>[
                              headerBar(context),
                              issueBallMakeButton(model,context),
                              questBallMakeButton(context)
                            ],
                          )
                        ])))
              ]));
        }));
  }

  Container issueBallMakeButton(H002PageViewModel model,BuildContext context) {
    return Container(
        height: 130,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 4.00),
            color: Color(0xff455b63).withOpacity(0.08),
            blurRadius: 16,
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(8.00)),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                  height: 62,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.00),
                        topRight: Radius.circular(8.00)),
                    color: Color(0xffF9E3E3),
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/MainImage/photographer-5551_640.png"),
                        fit: BoxFit.cover),
                  )),
            ),
            Positioned(
              top: 14,
              left: 16,
              child:  Container(
                padding: EdgeInsets.fromLTRB(1, 1, 0, 0),
                height: 30.00,
                width: 30.00,
                child: Icon(
                  ForutonaIcon.issue,
                  color: Colors.white,
                  size: 18,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffdc3e57),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 14,
              left: 62,
              child: Text("이슈볼",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Color(0xff454f63),
                  )),
            ),
            Positioned(
              top: 79,
              left: 16,
              child: Container(
                width: MediaQuery.of(context).size.width-32,
                child: Text(
                    "실제 세상에서 일어나는 크고 작은 소식들을 지도 "
                    "위에 표시하고 공유할 수 있어요",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 12,
                      color: Color(0xff454f63),
                    )),
              ),
            ),
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.goAddIssueBall,
                child: Text(""),
              ),
            )
          ],
        ));
  }

  Container questBallMakeButton(BuildContext context) {
    return Container(
        height: 130,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 4.00),
            color: Color(0xff455b63).withOpacity(0.08),
            blurRadius: 16,
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(8.00)),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                  height: 62,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.00),
                        topRight: Radius.circular(8.00)),
                    color: Color(0xffE5EAFF),
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/MainImage/adult-1850181_1920.png"),
                        fit: BoxFit.cover),
                  )),
            ),
            Positioned(
              top: 14,
              left: 16,
              child:  Container(
                padding: EdgeInsets.fromLTRB(1, 1, 0, 0),
                height: 30.00,
                width: 30.00,
                child: Icon(
                  ForutonaIcon.quest,
                  color: Colors.white,
                  size: 13,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff4F72FF),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 14,
              left: 62,
              child: Text("퀘스트 볼",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Color(0xff454f63),
                  )),
            ),
            Positioned(
              top: 79,
              width: MediaQuery.of(context).size.width-32,
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                    "현실에서 해결해야할 임무가 있으신가요? 보상을 건 "
                    "퀘스트를 만들어 세상에 도움을 청해보세요.",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 12,
                      color: Color(0xff454f63),
                    )),
              ),
            ),
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {},
                child: Text(""),
              ),
            )
          ],
        ));
  }

  Container headerBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xffffffff), boxShadow: [
        BoxShadow(
          offset: Offset(0.00, 3.00),
          color: Color(0xff000000).withOpacity(0.03),
          blurRadius: 6,
        )
      ]),
      height: 56,
      child: Row(
        children: <Widget>[
          BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black),
          Text("볼 선택하기",
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xff454f63),
              ))
        ],
      ),
    );
  }
}
