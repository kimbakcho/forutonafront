import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/LoadingOverlay%20.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/C007SelectMakeCubeView.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/FcubeSearch.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class C001MakePageView extends StatefulWidget {
  C001MakePageView({Key key}) : super(key: key);

  @override
  _C001MakePageViewState createState() => _C001MakePageViewState();
}

class _C001MakePageViewState extends State<C001MakePageView>
    with AfterInitMixin, AutomaticKeepAliveClientMixin {
  Widget maincontentwidget = Container();
  bool floatingbtnflag = true;
  bool overscrollflag = false;
  double overscrollvalue = 0;
  String currentorderby = "Maketime";
  bool currentdesc = true;
  int currentofsset = 0;

  @override
  void didInitState() async {}

  resetcubeList() async {
    GlobalStateContainer.of(context).resetcubeListUtilcubeList();
    GlobalStateContainer.of(context).setfcubeListUtilisLoading(true);
    setState(() {});
    GlobalStateContainer.of(context).addfcubeListUtilcubeList(
        await FcubeExtender1.getusercubes(FcubeSearch(
            limit: 10,
            offset: 0,
            isdesc: currentdesc,
            orderby: currentorderby)));
    Position currentposition =
        GlobalStateContainer.of(context).state.currentposition;
    GlobalStateContainer.of(context)
        .updateCubeListupdatedistancewithme(currentposition);
    GlobalStateContainer.of(context).setfcubeListUtilisLoading(false);
    setState(() {});
  }

  bottmappendcubelist() async {
    currentofsset += 10;
    GlobalStateContainer.of(context).setfcubeListUtilisLoading(true);
    setState(() {});
    int beforeitemlength =
        GlobalStateContainer.of(context).state.fcubeListUtil.cubeList.length;
    GlobalStateContainer.of(context).addfcubeListUtilcubeList(
        await FcubeExtender1.getusercubes(FcubeSearch(
            limit: 10,
            offset: currentofsset,
            isdesc: currentdesc,
            orderby: currentorderby)));
    int afteritemlength =
        GlobalStateContainer.of(context).state.fcubeListUtil.cubeList.length;
    if (beforeitemlength == afteritemlength) {
      currentofsset -= 10;
    }
    Position currentposition =
        GlobalStateContainer.of(context).state.currentposition;
    GlobalStateContainer.of(context)
        .updateCubeListupdatedistancewithme(currentposition);
    GlobalStateContainer.of(context).setfcubeListUtilisLoading(false);
    setState(() {});
  }

  Widget makeMainContentWidget() {
    if (GlobalStateContainer.of(context).state.userInfoMain != null) {
      //login
      if (GlobalStateContainer.of(context)
              .state
              .fcubeListUtil
              .cubeList
              .length ==
          0) {
        return ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 66,
            ),
            Container(
                child: Container(
              margin: EdgeInsets.fromLTRB(72, 0, 72, 0),
              height: 103,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/MainImage/fantasy-1.png"),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            )),
            SizedBox(
              height: 33,
            ),
            Container(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                        "${GlobalStateContainer.of(context).state.userInfoMain.nickname}",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff454F63),
                    ),
                    children: [
                      TextSpan(
                          text: "님",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14,
                            color: Color(0xffB1B1B1),
                          ))
                    ]),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Text("당신의 세상에는\n지금 어떤 일들이 일어나고 있나요?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontSize: 14,
                    color: Color(0xffB1B1B1),
                  )),
            )
          ],
        );
      } else {
        List<FcubeExtender1> fcubelist =
            (GlobalStateContainer.of(context).state.fcubeListUtil.cubeList);
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              ScrollUpdateNotification scroller = scrollNotification;
              if (scroller.scrollDelta > 1) {
                floatingbtnflag = false;
                setState(() {});
              } else if (scroller.scrollDelta < 0) {
                floatingbtnflag = true;
                setState(() {});
              }
            } else if (scrollNotification is OverscrollNotification) {
              OverscrollNotification scroller = scrollNotification;
              overscrollflag = true;
              overscrollvalue = scroller.overscroll;
            } else if (scrollNotification is ScrollEndNotification) {
              if (overscrollflag) {
                overscrollflag = false;
                if (overscrollvalue > 0) {
                  bottmappendcubelist();
                }
              }
            }
            return true;
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: fcubelist.length,
            itemBuilder: (BuildContext context, int index) {
              if (fcubelist[index].cubetype == FcubeType.questCube) {
                return Card(
                    // color: Color(0xFFfae2e6),
                    color: Color(0xffe5eaff),
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin:
                                          EdgeInsets.fromLTRB(16, 16, 16, 16),
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        ForutonaIcon.quest,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xff4F72FF),
                                        shape: BoxShape.circle,
                                      )),
                                  Expanded(
                                    child: Container(
                                      width: 150,
                                      child: RichText(
                                        text: TextSpan(
                                            text: fcubelist[index].cubename,
                                            style: TextStyle(
                                              fontFamily: "Noto Sans CJK KR",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                              color: Color(0xff454f63),
                                            ),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      "\n${fcubelist[index].placeaddress}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "Noto Sans CJK KR",
                                                    fontSize: 11,
                                                    color: Color(0xff454f63)
                                                        .withOpacity(0.56),
                                                  ))
                                            ]),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 43,
                                      width: 43,
                                      margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 10,
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {},
                                          icon: Icon(
                                            ForutonaIcon.pointdash,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                  child: Text(
                                      "${(fcubelist[index].distancewithme.roundToDouble() / 1000).toStringAsFixed(1)} km 이내",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontSize: 10,
                                        color:
                                            Color(0xffff4f9a).withOpacity(0.56),
                                      ))),
                            )
                          ],
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Text(
                                    "${fcubelist[index].pointreward.toInt()}",
                                    style: TextStyle(
                                      fontFamily: "Gibson",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color(0xff78849e),
                                    )),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  ForutonaIcon.napoint,
                                  size: 18,
                                  color: Color(0xff78849E),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child:
                                    Text("${fcubelist[index].userexp.toInt()}",
                                        style: TextStyle(
                                          fontFamily: "Gibson",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Color(0xff78849e),
                                        )),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  ForutonaIcon.whatshot,
                                  size: 18,
                                  color: Color(0xff78849E),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Text(
                                    "${fcubelist[index].remindActiveTimetoDuration().inMinutes}",
                                    style: TextStyle(
                                      fontFamily: "Gibson",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color(0xff78849e),
                                    )),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  ForutonaIcon.accesstime,
                                  size: 18,
                                  color: Color(0xff78849E),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        )
                      ],
                    ));
              } else if (fcubelist[index].cubetype == FcubeType.issuecube) {
                return Card(
                    // color: Color(0xFFfae2e6),
                    color: Color(0xffFAE2E6),
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.only(left: 2),
                                      margin:
                                          EdgeInsets.fromLTRB(16, 16, 16, 16),
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        ForutonaIcon.issue,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xffDC3E57),
                                        shape: BoxShape.circle,
                                      )),
                                  Expanded(
                                    child: Container(
                                      width: 150,
                                      child: RichText(
                                        text: TextSpan(
                                            text: fcubelist[index].cubename,
                                            style: TextStyle(
                                              fontFamily: "Noto Sans CJK KR",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                              color: Color(0xff454f63),
                                            ),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      "\n${fcubelist[index].placeaddress}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "Noto Sans CJK KR",
                                                    fontSize: 11,
                                                    color: Color(0xff454f63)
                                                        .withOpacity(0.56),
                                                  ))
                                            ]),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 43,
                                      width: 43,
                                      margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 10,
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {},
                                          icon: Icon(
                                            ForutonaIcon.pointdash,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                  child: Text(
                                      "${(fcubelist[index].distancewithme.roundToDouble() / 1000).toStringAsFixed(1)} km 이내",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontSize: 10,
                                        color:
                                            Color(0xffff4f9a).withOpacity(0.56),
                                      ))),
                            )
                          ],
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Text("${fcubelist[index].cubelikes}",
                                    style: TextStyle(
                                      fontFamily: "Gibson",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color(0xff78849e),
                                    )),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  ForutonaIcon.thumbsup,
                                  size: 18,
                                  color: Color(0xff78849E),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Text("${fcubelist[index].cubedislikes}",
                                    style: TextStyle(
                                      fontFamily: "Gibson",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color(0xff78849e),
                                    )),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  ForutonaIcon.thumbsdown,
                                  size: 18,
                                  color: Color(0xff78849E),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Text("${fcubelist[index].commentcount}",
                                    style: TextStyle(
                                      fontFamily: "Gibson",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color(0xff78849e),
                                    )),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  ForutonaIcon.comment,
                                  size: 18,
                                  color: Color(0xff78849E),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Text(
                                    "${fcubelist[index].remindActiveTimetoDuration().inMinutes}",
                                    style: TextStyle(
                                      fontFamily: "Gibson",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color(0xff78849e),
                                    )),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  ForutonaIcon.accesstime,
                                  size: 18,
                                  color: Color(0xff78849E),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        )
                      ],
                    ));
              } else {
                return Container();
              }
            },
          ),
        );
      }
    } else {
      //notlogin
      return makeNotLoginWidget();
    }
  }

  Widget makeNotLoginWidget() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(
          height: 66,
        ),
        Container(
            child: Container(
          margin: EdgeInsets.fromLTRB(72, 0, 72, 0),
          height: 103,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/MainImage/fantasy-1.png"),
                  fit: BoxFit.contain),
              borderRadius: BorderRadius.all(Radius.circular(12))),
        )),
        SizedBox(
          height: 29,
        ),
        Container(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "소중한 당신",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff454F63),
                ),
                children: [
                  TextSpan(
                      text: "님",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 14,
                        color: Color(0xffB1B1B1),
                      ))
                ]),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          child: Text("당신의 세상에는\n지금 어떤 일들이 일어나고 있나요?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 14,
                color: Color(0xffB1B1B1),
              )),
        )
      ],
    );
  }

  Widget makeFloatingActionButton() {
    if (GlobalStateContainer.of(context).state.userInfoMain != null) {
      //login
      if (floatingbtnflag) {
        return makeLoginFloatingBtn();
      } else {
        return Container();
      }
    } else {
      //notlogin
      return makeNotLoginFloatingBtn();
    }
  }

  Widget makeLoginFloatingBtn() {
    if (GlobalStateContainer.of(context).state.fcubeListUtil.cubeList.length ==
        0) {
      return Container(
          width: 226,
          height: 117,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Container(
                  alignment: Alignment.center,
                  child: Text("별로 어렵지 않습니다.\n큐브를 한번 만들어 보실래요?",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 13,
                        color: Color(0xff454f63),
                      )),
                ),
                width: 190,
                height: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/MainImage/ballun.png"))),
              ),
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff454F63),
                    border: Border.all(color: Color(0xff39F999), width: 3)),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  shape: CircleBorder(),
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        settings: RouteSettings(name: "C007"),
                        builder: (context) {
                          return C007SelectMakeCubeView();
                        }));
                    resetcubeList();
                  },
                  child: Icon(
                    ForutonaIcon.mainfab,
                    size: 18,
                    color: Color(0xff39F999),
                  ),
                ),
              )
            ],
          ));
    } else {
      return Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff454F63),
            border: Border.all(color: Color(0xff39F999), width: 3)),
        child: FlatButton(
          padding: EdgeInsets.all(0),
          shape: CircleBorder(),
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                settings: RouteSettings(name: "C007"),
                builder: (context) {
                  return C007SelectMakeCubeView();
                }));
            resetcubeList();
          },
          child: Icon(
            ForutonaIcon.mainfab,
            size: 18,
            color: Color(0xff39F999),
          ),
        ),
      );
    }
  }

  Widget makeNotLoginFloatingBtn() {
    return Container(
      width: 226,
      height: 117,
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        Container(
          child: Container(
            alignment: Alignment.center,
            child: Text("큐브를 만들기 위해서는 \n 먼저 로그인이 필요합니다.",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 13,
                  color: Color(0xff454f63),
                )),
          ),
          width: 190,
          height: 70,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/MainImage/ballun.png"))),
        ),
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff454F63),
              border: Border.all(color: Color(0xff39F999), width: 3)),
          child: FlatButton(
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            onPressed: () {},
            child: Icon(
              ForutonaIcon.mainfab,
              size: 18,
              color: Color(0xff39F999),
            ),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        isLoading:
            GlobalStateContainer.of(context).state.fcubeListUtil.isLoading,
        progressIndicator: Loading(
            indicator: BallScaleIndicator(),
            size: 100.0,
            color: Theme.of(context).accentColor),
        child: Scaffold(
          body: Container(
            child: makeMainContentWidget(),
          ),
          floatingActionButton: makeFloatingActionButton(),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
