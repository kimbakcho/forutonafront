import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BasicReViewsContentBar extends StatelessWidget {
  final FBallReplyResDto _fBallReplyResDto;
  final bool showChildReply;
  final bool showEditBtn;

  BasicReViewsContentBar(
      {Key key,
      FBallReplyResDto fBallReplyResDto,
      this.showChildReply,
      this.showEditBtn})
      : _fBallReplyResDto = fBallReplyResDto,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BasicReViewsContentBarViewModel(
            fBallReplyResDto: _fBallReplyResDto),
        child:
            Consumer<BasicReViewsContentBarViewModel>(builder: (_, model, __) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
            key: Key(_fBallReplyResDto.replyUuid),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 8, 0),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(model.userProfilePictureUrl),
                              fit: BoxFit.cover)),
                    ),
                    Expanded(
                        child: Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(model.userNickName,
                                style: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: const Color(0xff454f63),
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                        ],
                      ),
                      Row(children: <Widget>[
                        Container(
                            child: Text(
                          model.getDisplayWriteTime(),
                          style: GoogleFonts.notoSans(
                            fontSize: 10,
                            color: const Color(0xff78849e),
                            height: 1.6,
                          ),
                        )),
                        model.hasValuationHistory()
                            ? Container(
                                margin: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                height: 7,
                                width: 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xffE4E7E8),
                                ),
                              )
                            : Container(),
                        Container(
                          child: Text(model.getEvaluationInformation(),
                              style: GoogleFonts.notoSans(
                                fontSize: 10,
                                color: const Color(0xff3497fd),
                                height: 1.6,
                              )),
                        )
                      ]),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(model.replyText,
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: const Color(0xff454f63),
                                    height: 1.1428571428571428,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ])),
                    showEditBtn
                        ? Container(
                            child: RawMaterialButton(
                              constraints: BoxConstraints(),
                              child: Icon(ForutonaIcon.pointdash,
                                  color: Colors.black),
                            ),
                          )
                        : Container()
                  ],
                ),
                model.isChildReplyShow
                    ? childReplyToggleBtn(model)
                    : Container(),
                model.isChildReplyShow
                    ? Expanded(
                        child: ListView.builder(
                          itemCount:
                              _fBallReplyResDto.childFBallReplyResDto.length,
                          itemBuilder: (_, index) {
                            return BasicReViewsContentBar(
                                fBallReplyResDto: _fBallReplyResDto
                                    .childFBallReplyResDto[index],
                                showChildReply: showChildReply);
                          },
                        ),
                      )
                    : Container()
              ],
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffF4F4F6), width: 1))),
          );
        }));
  }

  Row childReplyToggleBtn(BasicReViewsContentBarViewModel model) {
    return Row(
      children: <Widget>[
        model.isChildReplyOpen
            ? RawMaterialButton(
                onPressed: () {
                  model.toggleChildOpenState();
                },
                constraints: BoxConstraints(),
                child: Text(model.getOpenedText()),
              )
            : RawMaterialButton(
                onPressed: () {
                  model.toggleChildOpenState();
                },
                constraints: BoxConstraints(),
                child: Text(model.getClosedText()),
              )
      ],
    );
  }
}

class BasicReViewsContentBarViewModel extends ChangeNotifier {
  final FBallReplyResDto fBallReplyResDto;
  bool isChildReplyOpen = false;
  bool showChildReply;

  BasicReViewsContentBarViewModel({this.fBallReplyResDto, this.showChildReply});

  get isChildReplyShow {
    if (fBallReplyResDto.childCount > 0 && showChildReply) {
      return true;
    } else {
      return false;
    }
  }

  String getEvaluationInformation() {
    if (hasValuationHistory()) {
      if (isIssueBall() && hasEvaluation()) {
        return "이슈볼을 평가";
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  bool hasValuationHistory() => fBallReplyResDto.fballValuationResDto != null;

  bool isIssueBall() =>
      fBallReplyResDto.ballUuid.ballType == FBallType.IssueBall;

  bool hasEvaluation() => fBallReplyResDto.fballValuationResDto.point > 0;

  String get userNickName {
    return fBallReplyResDto.userNickName;
  }

  String get userProfilePictureUrl {
    return fBallReplyResDto.userProfilePictureUrl;
  }

  String get replyText {
    return fBallReplyResDto.replyText;
  }

  String getOpenedText() {
    return "▲ 답글 숨기기(${fBallReplyResDto.childCount})";
  }

  String getClosedText() {
    return "▲ 답글 보기(${fBallReplyResDto.childCount})";
  }

  void toggleChildOpenState() {
    isChildReplyOpen = !isChildReplyOpen;
    notifyListeners();
  }

  String getDisplayWriteTime() {
    return TimeDisplayUtil.getCalcToStrFromNow(
        fBallReplyResDto.replyUploadDateTime);
  }
}
