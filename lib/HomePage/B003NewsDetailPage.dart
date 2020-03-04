import 'package:flutter/material.dart';
import 'package:forutonafront/HomePage/B004NewsInner.dart';
import 'package:forutonafront/HomePage/HomeMainTop.dart';
import 'package:forutonafront/HomePage/NewsObject.dart';
import 'package:intl/intl.dart';

class B003NewsDetailPage extends StatefulWidget {
  B003NewsDetailPage({Key key}) : super(key: key);

  @override
  _B003NewsDetailPageState createState() => _B003NewsDetailPageState();
}

class _B003NewsDetailPageState extends State<B003NewsDetailPage> {
  List<NewsObject> news = List<NewsObject>();

  @override
  void initState() {
    super.initState();
    news = NewsObject.getNewsObjectItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Text("새로운 소식",
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xff454f63),
            )),
      ),
      backgroundColor: Color(0xffE4E7E8),
      body: Stack(
        children: <Widget>[
          Container(
              child: ListView.builder(
                  itemCount: news.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.only(bottom: 8),
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
                        child: FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return B004NewsInner(newsitem: news[index]);
                              }));
                            },
                            padding: EdgeInsets.all(0),
                            child: Column(children: <Widget>[
                              Container(
                                  height: 227.00,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(news[index].imageUrl),
                                        fit: BoxFit.fitWidth),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.00),
                                      topRight: Radius.circular(12.00),
                                    ),
                                  )),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.all(16),
                                child: Text(news[index].title,
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xff454f63),
                                    )),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Row(children: <Widget>[
                                    Expanded(
                                      child: Text(news[index].category,
                                          style: TextStyle(
                                            fontFamily: "Noto Sans CJK KR",
                                            fontSize: 11,
                                            color: Color(0xff78849e),
                                          )),
                                    ),
                                    Text(
                                        "${DateFormat("yyyy.MM.dd").format(news[index].publishDate.toLocal())}",
                                        style: TextStyle(
                                          fontFamily: "Noto Sans CJK KR",
                                          fontSize: 11,
                                          color: Color(0xff78849e),
                                        ))
                                  ]))
                            ])));
                  }))
        ],
      ),
    );
  }
}
