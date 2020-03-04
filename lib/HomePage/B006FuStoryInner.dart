import 'package:flutter/material.dart';
import 'package:forutonafront/HomePage/FUSotryOjbect.dart';
import 'package:intl/intl.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class B006FuStoryInner extends StatefulWidget {
  B006FuStoryInner({this.story, Key key}) : super(key: key);
  final FUSotryOjbect story;

  @override
  _B006FuStoryInnerState createState() {
    return _B006FuStoryInnerState(story: story);
  }
}

class _B006FuStoryInnerState extends State<B006FuStoryInner> {
  _B006FuStoryInnerState({this.story});
  FUSotryOjbect story;
  String network1 =
      "https://storage.googleapis.com/publicforutona/cuberelationimage/rawpixel.png";
  String network2 =
      "https://storage.googleapis.com/publicforutona/cuberelationimage/soule1.png";
  String dummpytext1 =
      "우리가 희망하는건 당신에게 매우 특별한 모험을 선사하는 것입니다. 홀로 떠나는 모험이 조금은 외롭다고 느껴지시겠지만 걱정하지 마세요! 당신의 모험을 포루투나가 언제나 응원하고 있으니까요! 먼저 이번 모험에 대해서 영상으로 만나보실까요?";
  String dummytext2 =
      "영상에서 보신 것과 같이 이번 모험은 아주 간단합니다. 영상 속 힌트를 찾아 가장 먼저 보물을 찾는 것이지요!";
  String dummytext3 = "하단에 [이벤트 참가하기] 버튼을 누르면 곧바로 이벤트를 진행하실 수 있습니다.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            Icon(
              ForutonaIcon.share,
              color: Color(0xff454F63),
            )
          ],
        ),
        backgroundColor: Color(0xffE4E7E8),
        body: Stack(children: <Widget>[
          ListView(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              children: <Widget>[
                TopPanel(story: story),
                SizedBox(height: 8),
                Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                              height: 205.00,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(network1),
                                    fit: BoxFit.fitWidth),
                                borderRadius: BorderRadius.circular(12.00),
                              )),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: Text(dummpytext1,
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontSize: 14,
                                    color: Color(0xff78849e),
                                  ))),
                          Container(
                              height: 205.00,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(network2),
                                    fit: BoxFit.fitWidth),
                                borderRadius: BorderRadius.circular(12.00),
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Text(dummytext2,
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 14,
                                  color: Color(0xff78849e),
                                )),
                          ),
                          Container(
                            child: Text("YOUTUBE 공식 채널",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 16,
                                  color: Color(0xff454f63),
                                )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "http://www.youtube.com/forutona",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontSize: 16,
                                      color: Color(0xff3497fd),
                                      decoration: TextDecoration.underline,
                                    )),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            child: Text("포루투나 소셜 계정?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 16,
                                  color: Color(0xff454f63),
                                )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "facebook.com/forutona",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontSize: 16,
                                      color: Color(0xff3497fd),
                                      decoration: TextDecoration.underline,
                                    )),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "instagram.com/forutona",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontSize: 16,
                                      color: Color(0xff3497fd),
                                      decoration: TextDecoration.underline,
                                    )),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "twitter.com/forutona",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontSize: 16,
                                      color: Color(0xff3497fd),
                                      decoration: TextDecoration.underline,
                                    )),
                              ]),
                            ),
                          ),
                        ])),
              ])
        ]));
  }
}

class TopPanel extends StatelessWidget {
  const TopPanel({
    Key key,
    @required this.story,
  }) : super(key: key);

  final FUSotryOjbect story;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Container(
          height: 234.00,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(story.imageUrl),
                fit: BoxFit.fitWidth,
              ))),
      Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(story.title,
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xff454f63),
                      ))),
              Container(
                child: Row(
                  children: <Widget>[
                    Text(story.category,
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 11,
                          color: Color(0xff78849e),
                        )),
                    Expanded(
                      child: Text(
                          "${DateFormat("yyyy.MM.dd").format(story.publishDate.toLocal())}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 12,
                            color: Color(0xff78849e),
                          )),
                    )
                  ],
                ),
              )
            ],
          ))
    ]));
  }
}
