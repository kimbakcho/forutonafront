import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FcubeExtenderMarkerGenerator.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeWidget extends StatefulWidget {
  YoutubeWidget({this.controller, key}) : super(key: key);
  final YoutubePlayerController controller;

  @override
  _YoutubeWidgetState createState() {
    return _YoutubeWidgetState(controller: this.controller);
  }
}

class _YoutubeWidgetState extends State<YoutubeWidget> with AfterLayoutMixin {
  _YoutubeWidgetState({this.controller});
  String title = "";
  int visitcount = 0;
  String publishDate = "";
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    isloading = true;
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    Dio dio = new Dio();
    String url = "https://www.youtube.com/watch?v=" + controller.initialVideoId;
    Response<String> response = await dio.get(url);
    title = parseToTitle(response.data);
    visitcount = parseToVisited(response.data);
    publishDate = parseToPublishDate(response.data);

    setState(() {});
  }

  String parseToTitle(String str) {
    String findhead = "<meta property=\"og:title\" content=\"";
    int startindex = str.indexOf(findhead);
    int endindex = str.indexOf('\"', startindex + findhead.length);
    return str.substring(startindex + findhead.length, endindex);
  }

  int parseToVisited(String str) {
    String findhead = "<meta itemprop=\"interactionCount\" content=\"";
    int startindex = str.indexOf(findhead);
    int endindex = str.indexOf('\"', startindex + findhead.length);
    String countstr = str.substring(startindex + findhead.length, endindex);
    return int.tryParse(countstr);
  }

  String parseToPublishDate(String str) {
    String findhead = "<meta itemprop=\"datePublished\" content=\"";
    int startindex = str.indexOf(findhead);
    int endindex = str.indexOf('\"', startindex + findhead.length);
    return str.substring(startindex + findhead.length, endindex);
  }

  YoutubePlayerController controller;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isloading,
      progressIndicator: Loading(
          indicator: BallScaleIndicator(),
          size: 100.0,
          color: Theme.of(context).accentColor),
      child: Container(
          decoration: BoxDecoration(
              color: Color(0xffe4e7e8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 4.00),
                  color: Color(0xff455b63).withOpacity(0.08),
                  blurRadius: 16,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(children: <Widget>[
            Container(
                child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: YoutubePlayer(
                    controller: controller,
                    onReady: () {
                      isloading = false;
                      setState(() {});
                    },
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                  ),
                ),
                // Positioned(
                //     right: 16,
                //     bottom: 16,
                //     child: Container(
                //         height: 40.00,
                //         width: 40.00,
                //         child: FlatButton(
                //             padding: EdgeInsets.all(0),
                //             onPressed: () {
                //               controller.play();
                //             },
                //             child: Container(
                //               padding: EdgeInsets.only(left: 3),
                //               child: Icon(
                //                 ForutonaIcon.yplay,
                //                 color: Colors.white,
                //                 size: 15,
                //               ),
                //               height: 30.00,
                //               width: 30.00,
                //               decoration: BoxDecoration(
                //                 color: Color(0xffff4f9a),
                //                 shape: BoxShape.circle,
                //               ),
                //             )),
                //         decoration: BoxDecoration(
                //           color: Color(0xffff4f9a).withOpacity(0.3),
                //           boxShadow: [
                //             BoxShadow(
                //               offset: Offset(0.00, 6.00),
                //               color: Color(0xff321636).withOpacity(0.44),
                //               blurRadius: 12,
                //             ),
                //           ],
                //           shape: BoxShape.circle,
                //         )))
              ],
            )),
            Container(
                padding: EdgeInsets.fromLTRB(9, 16, 9, 16),
                width: MediaQuery.of(context).size.width,
                height: 70.00,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xff454f63),
                            )),
                      ),
                      Container(
                        child: Text("조회수 $visitcount • $publishDate",
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontSize: 10,
                              color: Color(0xff78849e),
                            )),
                      )
                    ]))
          ])),
    );
  }
}
