import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FcubeDescription.dart';
import 'package:forutonafront/Common/FcubeExtenderMarkerGenerator.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/Common/PlayerjoincubeSearch.dart';
import 'package:forutonafront/Common/Pleyerjoincube.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class D007JoinBallsPageView extends StatefulWidget {
  D007JoinBallsPageView({Key key}) : super(key: key);

  @override
  _D007JoinBallsPageViewState createState() => _D007JoinBallsPageViewState();
}

class _D007JoinBallsPageViewState extends State<D007JoinBallsPageView>
    with AfterLayoutMixin {
  bool isLoading = false;
  PlayerjoincubeSearch searchitem;
  List<Pleyerjoincube> joincubelist;
  ScrollController _expandListController;
  @override
  void initState() {
    super.initState();
    joincubelist = List<Pleyerjoincube>();
    searchitem = PlayerjoincubeSearch();
    _expandListController = ScrollController();
    _expandListController.addListener(_expandListListener);
  }

  _expandListListener() async {
    //바텀 까지 스크롤 업함.
    if (_expandListController.offset >=
            _expandListController.position.maxScrollExtent &&
        !_expandListController.position.outOfRange) {
      isLoading = true;
      setState(() {});
      searchitem.limit = 10;
      searchitem.offset = joincubelist.length;
      Position currentposition =
          GlobalStateContainer.of(context).state.currentposition;
      joincubelist.addAll(await Pleyerjoincube.getPlayerJoinCubeList(
          searchitem, currentposition.latitude, currentposition.longitude));
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    isLoading = true;

    setState(() {});
    String uid = GlobalStateContainer.of(context).state.userInfoMain.uid;

    searchitem.playerUid = uid;
    searchitem.playerLatitude = 0;
    searchitem.playerLongitude = 0;
    searchitem.limit = 10;
    searchitem.offset = 0;
    searchitem.orderBy = "StartTime";
    searchitem.isDesc = true;
    Position currentposition =
        GlobalStateContainer.of(context).state.currentposition;
    joincubelist = await Pleyerjoincube.getPlayerJoinCubeList(
        searchitem, currentposition.latitude, currentposition.longitude);

    isLoading = false;
    setState(() {});
  }

  Widget selectBallMainImage(FcubeDescription description) {
    if (description.desimages.length == 0) {
      return Container();
    } else if (description.desimages.length == 1) {
      return Container(
        height: 102,
        margin: EdgeInsets.all(13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.00),
            image: DecorationImage(
                image: NetworkImage(description.desimages[0].src),
                fit: BoxFit.fitWidth)),
      );
    } else {
      return Container(
        height: 102,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ListView.builder(
            itemCount: description.desimages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.fromLTRB(13, 0, 0, 0),
                  height: 102,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.00),
                      image: DecorationImage(
                          image: NetworkImage(description.desimages[index].src),
                          fit: BoxFit.fitWidth)));
            }),
      );
    }
  }

  Widget getExpanedQuestBallWidget(Pleyerjoincube item) {
    FcubeDescription description =
        FcubeDescription.fromRawJson(item.contentValue);
    return Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff455b63).withOpacity(0.08),
                blurRadius: 16,
              ),
            ],
            borderRadius: BorderRadius.circular(12.00)),
        child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 33.00,
                      width: 33.00,
                      decoration: BoxDecoration(
                        color: Color(0xff4F72FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        ForutonaIcon.quest,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.cubeName,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xff454f63),
                              )),
                          Text(item.placeAddress,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontSize: 12,
                                color: Color(0xff454f63).withOpacity(0.56),
                              ))
                        ],
                      ),
                    ))
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xff4f72ff).withOpacity(0.15),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.00),
                    topRight: Radius.circular(12.00),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                    child: Text(
                        "${(item.distancewithme / 1000).toStringAsFixed(1)} km",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 10,
                          color: Color(0xffff4f9a).withOpacity(0.56),
                        ))),
              )
            ],
          ),
          Container(
              child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(13),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xffDC3E57), width: 1),
                          image: DecorationImage(
                              image: NetworkImage(item.makerProfilePicktureUrl),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.makerNickName,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xff454f63),
                              )),
                          Text("${item.makerLevel.toInt()} lev",
                              style: TextStyle(
                                fontFamily: "Gibson",
                                fontSize: 12,
                                color: Color(0xff454f63).withOpacity(0.56),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(child: selectBallMainImage(description)),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                  padding: EdgeInsets.all(13),
                  alignment: Alignment.topLeft,
                  child: Text(description.text)),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 3),
                      child: Text("${item.pointReward.toInt()}",
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
                      child: Text("${item.userExp.toInt()}",
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
                      child:
                          Text("${item.remindActiveTimetoDuration().inMinutes}",
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
          ))
        ]));
  }

  Widget getExpanedIssueBallWidget(Pleyerjoincube item) {
    FcubeDescription description =
        FcubeDescription.fromRawJson(item.contentValue);
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
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
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 33.00,
                      width: 33.00,
                      padding: EdgeInsets.only(left: 2),
                      decoration: BoxDecoration(
                        color: Color(0xffdc3e57),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        ForutonaIcon.issue,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.cubeName,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xff454f63),
                              )),
                          Text(item.placeAddress,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontSize: 12,
                                color: Color(0xff454f63).withOpacity(0.56),
                              ))
                        ],
                      ),
                    ))
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xffdc3e57).withOpacity(0.15),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.00),
                    topRight: Radius.circular(12.00),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                    child: Text(
                        "${(item.distancewithme / 1000).toStringAsFixed(1)} km",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 10,
                          color: Color(0xffff4f9a).withOpacity(0.56),
                        ))),
              )
            ],
          ),
          Container(
              child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(13),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xffDC3E57), width: 1),
                          image: DecorationImage(
                              image: NetworkImage(item.makerProfilePicktureUrl),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.makerNickName,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xff454f63),
                              )),
                          Text("${item.makerLevel.toInt()} lev",
                              style: TextStyle(
                                fontFamily: "Gibson",
                                fontSize: 12,
                                color: Color(0xff454f63).withOpacity(0.56),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(child: selectBallMainImage(description)),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                  padding: EdgeInsets.all(13),
                  alignment: Alignment.topLeft,
                  child: Text(description.text)),
              Container(
                  margin: EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 3),
                        child: Text("${item.cubeLikes}",
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
                        child: Text("${item.cubeDisLikes}",
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
                        child: Text("${item.commentCount}",
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
                            "${item.remindActiveTimetoDuration().inMinutes}",
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
                      )
                    ],
                  ))
            ],
          ))
        ],
      ),
    );
  }

  Widget selectBody() {
    if (joincubelist.length == 0) {
      return Container(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 122,
          ),
          Container(
            alignment: Alignment.center,
            child: Icon(
              ForutonaIcon.noballinbox,
              color: Color(0xFF999999),
              size: 50,
            ),
          ),
          SizedBox(
            height: 38,
          ),
          Container(
            alignment: Alignment.center,
            child: Text("아쉽게도\n참여하신 볼이 없습니다.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 14,
                  color: Color(0xffb1b1b1),
                )),
          )
        ],
      ));
    } else {
      return Container(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              controller: _expandListController,
              itemCount: joincubelist.length,
              itemBuilder: (context, index) {
                if (joincubelist[index].cubeType == FcubeType.issuecube) {
                  return getExpanedIssueBallWidget(joincubelist[index]);
                } else if (joincubelist[index].cubeType ==
                    FcubeType.questCube) {
                  return getExpanedQuestBallWidget(joincubelist[index]);
                } else {
                  return Container();
                }
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: Loading(
            indicator: BallScaleIndicator(),
            size: 100.0,
            color: Theme.of(context).accentColor),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("내가 참여한 볼",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                )),
          ),
          body: selectBody(),
        ));
  }
}
