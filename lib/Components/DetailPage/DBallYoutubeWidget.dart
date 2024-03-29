import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as Youtube;

class DBallYoutubeWidget extends StatefulWidget {
  final String? youtubeVideoId;

  DBallYoutubeWidget({this.youtubeVideoId});

  @override
  _DBallYoutubeWidgetState createState() => _DBallYoutubeWidgetState();
}

class _DBallYoutubeWidgetState extends State<DBallYoutubeWidget>
    with AutomaticKeepAliveClientMixin {
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (_) => ID001YoutubeWidgetViewModel(widget.youtubeVideoId!),
      child: Consumer<ID001YoutubeWidgetViewModel>(builder: (_, model, __) {
        return model.canDisplayYoutube()
            ? youtubeWidget(model, context)
            : Container();
      }),
    );
  }

  Container youtubeWidget(
      ID001YoutubeWidgetViewModel model, BuildContext context) {
    return model.isLoaded
        ? Container(
            height: 162,
            child: Row(children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(16, 30, 16, 20),
                  child: Row(children: <Widget>[
                    Container(
                      width: 124.0,
                      height: 102.0,
                      child: youtubeImageBox(model),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      width: MediaQuery.of(context).size.width - 124 - 32 - 16,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                model.currentYoutubeTitle!,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: const Color(0xff454f63),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 11),
                                child: Text(
                                  model.currentYoutubeAuthor!,
                                  style: GoogleFonts.notoSans(
                                    fontSize: 12,
                                    color: const Color(0xff78849e),
                                  ),
                                  textAlign: TextAlign.left,
                                )),
                            Container(
                                child: Text(
                              model.etc,
                              style: GoogleFonts.notoSans(
                                fontSize: 12,
                                color: const Color(0xff78849e),
                              ),
                              textAlign: TextAlign.left,
                            ))
                          ]),
                    )
                  ]))
            ]),
          )
        : Container(
            child: Text("Youtube Loading..."),
          );
  }

  Widget youtubeImageBox(ID001YoutubeWidgetViewModel model) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(model.currentYoutubeImage!),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Center(
        child: youtubePlayBtn(model),
      )
    ]);
  }

  Container youtubePlayBtn(ID001YoutubeWidgetViewModel model) {
    return Container(
      width: 50,
      height: 50,
      child: FlatButton(
        onPressed: () {
          model.goYoutubeIntent(model.youtubeVideoId!);
        },
        child: Icon(
          ForutonaIcon.youtube_r_,
          color: Colors.white,
        ),
        shape: CircleBorder(),
      ),
      decoration: BoxDecoration(
          color: Color(0xff454F63).withOpacity(0.5), shape: BoxShape.circle),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ID001YoutubeWidgetViewModel extends ChangeNotifier {
  final String? youtubeVideoId;

  bool isLoaded = false;
  String? currentYoutubeImage;
  String? currentYoutubeTitle;
  String? currentYoutubeAuthor;
  int? currentYoutubeView;
  DateTime? currentYoutubeUploadDate;

  Youtube.YoutubeExplode _youtubeExplode = Youtube.YoutubeExplode();

  ID001YoutubeWidgetViewModel(this.youtubeVideoId) {
    if (this.canDisplayYoutube()) {
      youtubeLoad(youtubeVideoId!);
    }
  }

  youtubeLoad(String videoId) async {
    var video = await _youtubeExplode.videos.get(videoId);
    if (video.thumbnails.highResUrl != null) {
      currentYoutubeImage = video.thumbnails.highResUrl;
    } else if (video.thumbnails.mediumResUrl != null) {
      currentYoutubeImage = video.thumbnails.mediumResUrl;
    } else {
      currentYoutubeImage = video.thumbnails.lowResUrl;
    }
    currentYoutubeTitle = video.title;
    currentYoutubeAuthor = video.author;
    currentYoutubeView = video.engagement.viewCount;
    currentYoutubeUploadDate = video.uploadDate;
    isLoaded = true;
    notifyListeners();
  }

  Future<void> goYoutubeIntent(String youtubeVideoId) async {
    if (Platform.isAndroid) {
      try {
        AndroidIntentAdapter intent = AndroidIntentAdapterImpl();
        intent.createIntent(
            action: "action_view", data: "vnd.youtube:$youtubeVideoId",
        );
        await intent.launch();
      } catch (ex) {
        AndroidIntentAdapter intent = AndroidIntentAdapterImpl();
        intent.createIntent(
            action: "action_view",
            data: "https://www.youtube.com/watch?v=$youtubeVideoId");
        await intent.launch();
      }
    }
  }

  String get youtubeUploadDate {
    return TimeDisplayUtil.getCalcToStrFromNow(currentYoutubeUploadDate!);
  }

  String get etc {
    return "조회수 " + currentYoutubeView.toString() + " • " + youtubeUploadDate;
  }

  bool canDisplayYoutube() {
    if (youtubeVideoId != null && youtubeVideoId!.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _youtubeExplode.close();
  }
}
