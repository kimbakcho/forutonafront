import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_parser/youtube_parser.dart';

class YoutubeUrlUploadComponent extends StatelessWidget {
  final YoutubeUrlUploadComponentController youtubeUrlUploadComponentController;

  final EdgeInsets margin;

  const YoutubeUrlUploadComponent(
      {Key key, this.youtubeUrlUploadComponentController, this.margin = const EdgeInsets.all(0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => YoutubeUrlUploadComponentViewModel(
            this.youtubeUrlUploadComponentController),
        child: Consumer<YoutubeUrlUploadComponentViewModel>(
            builder: (_, model, child) {
          return model.isShow
              ? Container(
                  margin: margin,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('YOUTUBE 동영상 첨부',
                                style: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                ))),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  model.youtubeLink.isNotEmpty
                                      ? model.youtubeLink
                                      : '동영상 링크를 복사해서 붙여넣기 하세요.',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 13,
                                    color: const Color(0xff3a3e3f),
                                  )),
                              FlatButton(
                                  onPressed: () {
                                    model.youtubeLink.isNotEmpty
                                        ? model._deleteYoutubeUrl()
                                        : model.pasteFromClipBoard();
                                  },
                                  color: model.youtubeLink.isNotEmpty
                                      ? Color(0xffFF2783)
                                      : Color(0xff3497FD),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Text(
                                      model.youtubeLink.isNotEmpty
                                          ? "삭제하기"
                                          : "붙혀넣기",
                                      style: GoogleFonts.notoSans(
                                        fontSize: 11,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w500,
                                      )))
                            ])
                      ]),
                )
              : Container();
        }));
  }
}

class YoutubeUrlUploadComponentViewModel extends ChangeNotifier {
  final YoutubeUrlUploadComponentController youtubeUrlUploadComponentController;

  bool isShow = false;

  String youtubeLink = "";

  String youtubeId = "";

  YoutubeUrlUploadComponentViewModel(this.youtubeUrlUploadComponentController) {
    if (this.youtubeUrlUploadComponentController != null) {
      this.youtubeUrlUploadComponentController._viewModel = this;
    }
  }

  Future<String> copyClipBoard() async {
    ClipboardData clipBoardData = await Clipboard.getData("text/plain");
    var currentClipBoardData = clipBoardData.text.trim();
    return currentClipBoardData;
  }

  Future<bool> validYoutubeLinkCheck() async {
    var url = await copyClipBoard();
    String idFromUrl = getIdFromUrl(url);
    if (idFromUrl == null) {
      Fluttertoast.showToast(
          msg: "유효한 유튜브 링크가 아닙니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      return false;
    } else {
      return true;
    }
  }

  _toggle() {
    this.isShow = !this.isShow;
    notifyListeners();
  }

  void pasteFromClipBoard() async {
    var result = await validYoutubeLinkCheck();
    if (result) {
      var url = await copyClipBoard();
      youtubeLink = url;
      youtubeId = getIdFromUrl(youtubeLink);
      notifyListeners();
    }
  }

  void _deleteYoutubeUrl() {
    youtubeLink = "";
    youtubeId = "";
    notifyListeners();
  }
}

class YoutubeUrlUploadComponentController {
  YoutubeUrlUploadComponentViewModel _viewModel;

  toggle() {
    _viewModel._toggle();
  }

  String getYoutubeId() {
    return _viewModel.youtubeId;
  }

  deleteYoutubeUrl() {
    _viewModel._deleteYoutubeUrl();
  }
}