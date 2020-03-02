import 'package:after_init/after_init.dart';
import 'package:chewie2/chewie2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as Youtube;

class YoutubeWidget2 extends StatefulWidget {
  YoutubeWidget2({this.id, Key key}) : super(key: key);
  final String id;
  @override
  _YoutubeWidget2State createState() => _YoutubeWidget2State();
}

class _YoutubeWidget2State extends State<YoutubeWidget2> with AfterInitMixin {
  var yt = Youtube.YoutubeExplode();
  var media;
  String muxorigin;
  ChewieController chewieController;
  VideoPlayerController controller;
  String title = "";
  int visitcount = 0;
  String publishDate = "";
  String imageurl = "";
  bool isloading = false;
  GlobalKey videokey = GlobalKey();
  bool isfirst = true;
  @override
  void initState() {
    super.initState();
    isfirst = true;
  }

  @override
  void didInitState() async {
    isloading = true;
    setState(() {});
    Dio dio = new Dio();
    media = await yt.getVideoMediaStream(widget.id);
    print(media.muxed.last.url.toString());
    String url = "https://www.youtube.com/watch?v=" + widget.id;
    Response<String> response = await dio.get(url);
    title = parseToTitle(response.data);
    visitcount = parseToVisited(response.data);
    publishDate = parseToPublishDate(response.data);
    imageurl = parseToImage(response.data);
    controller = VideoPlayerController.network(media.muxed.last.url.toString())
      ..initialize().then((value) {
        setState(() {});
      });
    chewieController = ChewieController(
      videoPlayerController: controller,
      allowFullScreen: true,
      autoInitialize: true,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: true,
    );

    isloading = false;
    setState(() {});
  }

  initvideoflag() {
    if (controller != null && controller.value.initialized) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
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
              child: initvideoflag()
                  ? Column(
                      children: <Widget>[
                        Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            !isfirst
                                ? ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                    child: Chewie(
                                      key: videokey,
                                      controller: chewieController,
                                    ),
                                  )
                                : Container(),
                            isfirst
                                ? Container(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      margin: EdgeInsets.all(16),
                                      width: 40,
                                      height: 40,
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                          height: 30.00,
                                          width: 30.00,
                                          decoration: BoxDecoration(
                                            color: Color(0xffff4f9a),
                                            shape: BoxShape.circle,
                                          ),
                                          child: FlatButton(
                                            padding:
                                                EdgeInsets.fromLTRB(3, 0, 0, 0),
                                            onPressed: () {
                                              isfirst = false;
                                              controller.play();
                                              setState(() {});
                                            },
                                            child: Icon(
                                              ForutonaIcon.yplay,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          )),
                                      decoration: BoxDecoration(
                                          color: Color(0xffFF4F9A)
                                              .withOpacity(0.3),
                                          shape: BoxShape.circle),
                                    ),
                                    width: (context.findRenderObject()
                                            as RenderBox)
                                        .size
                                        .width,
                                    height: MediaQuery.of(context).size.height *
                                            0.5 -
                                        70,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(imageurl),
                                            fit: BoxFit.fill)),
                                  )
                                : Container(),
                          ],
                        ),
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
                                    child:
                                        Text("조회수 $visitcount • $publishDate",
                                            style: TextStyle(
                                              fontFamily: "Noto Sans CJK KR",
                                              fontSize: 10,
                                              color: Color(0xff78849e),
                                            )),
                                  )
                                ]))
                      ],
                    )
                  : Container(),
            ),
            isloading
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
          ],
        ));
  }

  Size _getyoutubesize() {
    final RenderBox renderBoxRed = videokey.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    return sizeRed;
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

  String parseToImage(String str) {
    String findhead = "<meta property=\"og:image\" content=\"";
    int startindex = str.indexOf(findhead);
    int endindex = str.indexOf('\"', startindex + findhead.length);
    return str.substring(startindex + findhead.length, endindex);
  }
}
