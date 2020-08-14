import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/BasicReViewsInsert.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BasicReViewsContentBar extends StatelessWidget {
  final FBallReplyResDto _fBallReplyResDto;
  final bool showChildReply;
  final bool canSubReplyInsert;
  final bool showEditBtn;
  final bool hasBoardLine;
  final bool hasBottomPadding;
  final ReviewInertMediator _reviewInertMediator;

  BasicReViewsContentBar(
      {Key key,
      FBallReplyResDto fBallReplyResDto,
      ReviewInertMediator reviewInertMediator,
      this.showChildReply,
      this.showEditBtn,
      this.canSubReplyInsert, this.hasBoardLine, this.hasBottomPadding})
      : _fBallReplyResDto = fBallReplyResDto,
        _reviewInertMediator = reviewInertMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BasicReViewsContentBarViewModel(
            showChildReply: showChildReply,
            fBallReplyUseCaseInputPort: sl(),
            reviewInertMediator: _reviewInertMediator,
            fBallReplyResDto: _fBallReplyResDto),
        child:
            Consumer<BasicReViewsContentBarViewModel>(builder: (_, model, __) {
          return InkWell(
            onTap: () {
              if (canSubReplyInsert) {
                model.subReplyInsertOpen(context);
              }
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0, hasBottomPadding ? 16: 0),
              key: Key(_fBallReplyResDto.replyUuid),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 8, 0),
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    NetworkImage(model.userProfilePictureUrl),
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
                        model.isChildReplyShow
                            ? childReplyToggleBtn(model)
                            : Container()
                      ])),
                      showEditBtn
                          ? Container(
                              child: RawMaterialButton(
                                onPressed: () {},
                                constraints: BoxConstraints(),
                                child: Icon(ForutonaIcon.pointdash,
                                    color: Colors.black),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  model.isChildReplyOpen
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              _fBallReplyResDto.childFBallReplyResDto.length,
                          itemBuilder: (_, index) {
                            return BasicReViewsContentBar(
                              canSubReplyInsert: false,
                               showEditBtn: true,
                                hasBoardLine: false,
                                hasBottomPadding: false,
                                fBallReplyResDto: _fBallReplyResDto
                                    .childFBallReplyResDto[index],
                                showChildReply: false);
                          },
                        )
                      : Container()
                ],
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xffF4F4F6), width: hasBoardLine? 1 : 0))),
            ),
          );
        }));
  }

  Widget childReplyToggleBtn(BasicReViewsContentBarViewModel model) {
    return Row(
      children: <Widget>[
        model.isChildReplyOpen
            ? InkWell(
                onTap: () {
                  model.toggleChildOpenState();
                },
                child: Text(
                  model.getOpenedText(),
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xff007eff),
                    fontWeight: FontWeight.w700,
                    height: 1.1666666666666667,
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  model.toggleChildOpenState();
                },
                child: Text(model.getClosedText(),
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xff007eff),
                      fontWeight: FontWeight.w700,
                      height: 1.1666666666666667,
                    )),
              )
      ],
    );
  }
}

class BasicReViewsContentBarViewModel extends ChangeNotifier {
  final FBallReplyResDto fBallReplyResDto;
  final ReviewInertMediator _reviewInertMediator;
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;
  bool isChildReplyOpen = false;
  bool showChildReply;

  BasicReViewsContentBarViewModel(
      {this.fBallReplyResDto,
      this.showChildReply,
      FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort,
      ReviewInertMediator reviewInertMediator})
      : _reviewInertMediator = reviewInertMediator,
        _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort;

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
    return "▼ 답글 보기(${fBallReplyResDto.childCount})";
  }

  void toggleChildOpenState() async {
    if (!isChildReplyOpen) {
      fBallReplyResDto.childFBallReplyResDto = await getSubReply();

    } else {
      fBallReplyResDto.childFBallReplyResDto = [];
    }
    isChildReplyOpen = !isChildReplyOpen;
    notifyListeners();
  }

  Future<List<FBallReplyResDto>> getSubReply() async {
    FBallReplyReqDto reqDto = FBallReplyReqDto();
    reqDto.ballUuid = fBallReplyResDto.ballUuid.ballUuid;
    reqDto.replyNumber = fBallReplyResDto.replyNumber;
    reqDto.reqOnlySubReply = true;
    PageWrap<FBallReplyResDto> pageDtos = await _fBallReplyUseCaseInputPort
        .reqFBallReply(reqDto, Pageable(0, 99999, "ReplySort,ASC"));
    return pageDtos.content;

  }

  String getDisplayWriteTime() {
    return TimeDisplayUtil.getCalcToStrFromNow(
        fBallReplyResDto.replyUploadDateTime);
  }

  void subReplyInsertOpen(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return BasicReViewsInsert(
            ballUuid: fBallReplyResDto.ballUuid.ballUuid,
            reviewInertMediator: _reviewInertMediator,
            parentFBallReplyResDto: fBallReplyResDto,
            autoFocus: true,
          );
        });
    fBallReplyResDto.childFBallReplyResDto = await getSubReply();
    fBallReplyResDto.childCount =  fBallReplyResDto.childFBallReplyResDto.length;
    notifyListeners();
  }

  bool isRootReply() => fBallReplyResDto.replySort == 0;

}
