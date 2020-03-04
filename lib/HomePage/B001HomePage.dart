import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/Fcubetag.dart';
import 'package:forutonafront/Common/Fcubetagextender1.dart';
import 'package:forutonafront/HomePage/B002MainTopInner.dart';
import 'package:forutonafront/HomePage/B003NewsDetailPage.dart';
import 'package:forutonafront/HomePage/B004NewsInner.dart';
import 'package:forutonafront/HomePage/B005FUStoryDetailPage.dart';
import 'package:forutonafront/HomePage/B006FuStoryInner.dart';
import 'package:forutonafront/HomePage/FUSotryOjbect.dart';
import 'package:forutonafront/HomePage/HomeMainTop.dart';
import 'package:forutonafront/HomePage/NewsObject.dart';
import 'package:forutonafront/HomePage/TagsRecomandWidget.dart';

import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:intl/intl.dart';

class B001HomePage extends StatefulWidget {
  B001HomePage({Key key}) : super(key: key);

  @override
  _B001HomePageState createState() => _B001HomePageState();
}

class _B001HomePageState extends State<B001HomePage> {
  bool isLoading = false;
  List<HomeMainTop> tops = List<HomeMainTop>();
  List<NewsObject> news = List<NewsObject>();
  List<FUSotryOjbect> storys = List<FUSotryOjbect>();
  List<String> recomandtags = List<String>();
  TagsController tagsController = TagsController();
  ScrollController scrollcontroller = ScrollController();
  @override
  void initState() {
    super.initState();
    tops = HomeMainTop.getMainTopItems();
    news = NewsObject.getNewsObjectItems();
    storys = FUSotryOjbect.getFUSotryOjbectItems();
    recomandtags = Fcubetag.recomandtegs();
    tagsController.taglists = recomandtags;

    tagsController.onLoadingfinish = onLoadingfinish;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
        backgroundColor: Color(0xffE4E7E8),
        body: Container(
          child: ListView(
            controller: scrollcontroller,
            shrinkWrap: true,
            children: <Widget>[
              MainTopPanel(tops: tops),
              SizedBox(
                height: 8,
              ),
              NewsPanel(news: news),
              SizedBox(
                height: 8,
              ),
              ForutonaStroyPanel(storys: storys),
              SizedBox(
                height: 8,
              ),
              TagsRecomandWidget(
                tagsController: tagsController,
              ),
            ],
          ),
        ),
      ),
      isLoading
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
    ]);
  }

  onLoadingfinish(List<Fcubetagextender1> item) {
    scrollcontroller.animateTo(
        scrollcontroller.position.maxScrollExtent + ((item.length / 2) * 168),
        duration: Duration(milliseconds: 500),
        curve: Curves.linear);
    setState(() {});
  }
}

class ForutonaStroyPanel extends StatelessWidget {
  const ForutonaStroyPanel({
    Key key,
    @required this.storys,
  }) : super(key: key);

  final List<FUSotryOjbect> storys;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 333,
        padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
        color: Color(0xffffffff),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child: Text("포루투나 스토리",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff454f63),
                    )),
              ),
              Container(
                child: FlatButton(
                  padding: EdgeInsets.only(left: 30),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return B005FUStoryDetailPage();
                    }));
                  },
                  child: Text("더 보기",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Color(0xff3497fd),
                      )),
                ),
              )
            ]),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: storys.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                      height: 76.00,
                      margin: EdgeInsets.only(bottom: 16),
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return B006FuStoryInner(story: storys[index]);
                          }));
                        },
                        child: Stack(children: <Widget>[
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 76,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              storys[index].imageUrl),
                                          fit: BoxFit.fill)),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Text(
                                    storys[index].title,
                                    softWrap: true,
                                  ),
                                )
                              ]),
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.25 + 8,
                            bottom: 9,
                            child: Text(storys[index].category,
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 11,
                                  color: Color(0xff78849e),
                                )),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 9,
                            child: Text(
                                "${DateFormat("yyyy.MM.dd").format(storys[index].publishDate.toLocal())}",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 11,
                                  color: Color(0xff78849e),
                                )),
                          )
                        ]),
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
                      ));
                })
          ],
        ));
  }
}

class NewsPanel extends StatelessWidget {
  const NewsPanel({
    Key key,
    @required this.news,
  }) : super(key: key);

  final List<NewsObject> news;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 333,
        padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
        color: Color(0xffffffff),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child: Text("새로운 소식",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff454f63),
                    )),
              ),
              Container(
                child: FlatButton(
                  padding: EdgeInsets.only(left: 30),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return B003NewsDetailPage();
                    }));
                  },
                  child: Text("더 보기",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Color(0xff3497fd),
                      )),
                ),
              )
            ]),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: news.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                      height: 76.00,
                      margin: EdgeInsets.only(bottom: 16),
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return B004NewsInner(newsitem: news[index]);
                          }));
                        },
                        child: Stack(children: <Widget>[
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 76,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              news[index].imageUrl),
                                          fit: BoxFit.fill)),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Text(
                                    news[index].title,
                                    softWrap: true,
                                  ),
                                )
                              ]),
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.25 + 8,
                            bottom: 9,
                            child: Text(news[index].category,
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 11,
                                  color: Color(0xff78849e),
                                )),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 9,
                            child: Text(
                                "${DateFormat("yyyy.MM.dd").format(news[index].publishDate.toLocal())}",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 11,
                                  color: Color(0xff78849e),
                                )),
                          )
                        ]),
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
                      ));
                })
          ],
        ));
  }
}

class MainTopPanel extends StatelessWidget {
  const MainTopPanel({
    Key key,
    @required this.tops,
  }) : super(key: key);

  final List<HomeMainTop> tops;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 274,
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Swiper(
            pagination: SwiperCustomPagination(builder: (context, config) {
              Widget child = Container(
                  margin: EdgeInsets.all(16),
                  child: DotSwiperPaginationBuilder(
                          activeColor: Color(0xff454F63),
                          activeSize: 10,
                          size: 6,
                          color: Color(0xffB1B1B1),
                          space: 2)
                      .build(context, config));
              return Align(alignment: Alignment.bottomCenter, child: child);
            }),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Stack(children: <Widget>[
                Container(
                  child: FlatButton(
                    child: Container(),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return B002MainTopInner(
                          homeMainTop: tops[index],
                        );
                      }));
                    },
                  ),
                  height: 222,
                  margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                          image: NetworkImage(tops[index].imageUrl),
                          fit: BoxFit.fill)),
                ),
                Positioned(
                  bottom: 98,
                  left: 24,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(tops[index].title,
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 16,
                          color: Color(0xffffffff),
                        )),
                  ),
                ),
                Positioned(
                    right: 24,
                    bottom: 60,
                    child: Text(
                        "${DateFormat("yyyy.MM.dd").format(tops[index].publishDate.toLocal())}",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 12,
                          color: Color(0xffcccccc),
                        ))),
                tops[index].isEvent
                    ? Positioned(
                        left: 24,
                        bottom: 58,
                        child: Container(
                          alignment: Alignment.center,
                          child: FlatButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(0),
                            child: Text("이벤트",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 10,
                                  color: Color(0xffffffff),
                                )),
                          ),
                          height: 24.00,
                          width: 63.00,
                          decoration: BoxDecoration(
                            color: Color(0xffff9057),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.00, 3.00),
                                color: Color(0xff000000).withOpacity(0.16),
                                blurRadius: 6,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12.00),
                          ),
                        ),
                      )
                    : Container()
              ]);
            }));
  }
}
