import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_parser/youtube_parser.dart';

import '../IM001Mode.dart';

class YoutubeUrlUploadComponent extends StatelessWidget {
  final YoutubeUrlUploadComponentController youtubeUrlUploadComponentController;

  final EdgeInsets margin;

  final IM001Mode im001mode;

  final FBallResDto preSetBallResDto;

  const YoutubeUrlUploadComponent(
      {Key key,
      this.youtubeUrlUploadComponentController,
      this.margin = const EdgeInsets.all(0),
      this.im001mode,
      this.preSetBallResDto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => YoutubeUrlUploadComponentViewModel(
            this.youtubeUrlUploadComponentController,
            im001mode,
            preSetBallResDto),
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
                                          : "붙여넣기",
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

  final IM001Mode im001mode;

  final FBallResDto preSetBallResDto;

  bool isShow = false;

  String youtubeLink = "";

  String youtubeId = "";

  IssueBallDisPlayUseCase _issueBallDisPlayUseCase;

  YoutubeUrlUploadComponentViewModel(this.youtubeUrlUploadComponentController,
      this.im001mode, this.preSetBallResDto) {
    if (this.youtubeUrlUploadComponentController != null) {
      this.youtubeUrlUploadComponentController._viewModel = this;
    }
    if (im001mode == IM001Mode.modify) {
      _issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
          fBallResDto: preSetBallResDto, geoLocatorAdapter: sl());
      if (_issueBallDisPlayUseCase.getYoutubeId() != "") {
        youtubeId = _issueBallDisPlayUseCase.getYoutubeId();
        youtubeLink = "https://youtu.be/"+youtubeId;
        isShow = true;
      }
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

  setYoutubeId(String videoId) {
    youtubeId = videoId;
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

  bool isShow(){
    if(_viewModel == null){
      return false;
    }
    return _viewModel.isShow;
  }

  String getYoutubeId() {
    return _viewModel.youtubeId;
  }

  void setYoutubeId(String videoId) {
    _viewModel.setYoutubeId(videoId);
  }

  deleteYoutubeUrl() {
    _viewModel._deleteYoutubeUrl();
  }
}
