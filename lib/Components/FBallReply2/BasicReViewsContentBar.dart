import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/CommonValue/Value/ReplyMaliciousType.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Domain/UseCase/MaliciousReplyUseCaseInputPort.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Components/BallOption/OtherUserBallPopup/OtherUserBallPopup.dart';
import 'package:forutonafront/Components/FBallReply2/ReplyOptionAction/ReplyOptionActionAlertDialogSheet.dart';

import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/JCodePage/J001/J001View.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'BasicReViewsInsert.dart';
import 'FBallReplyDisplayUtil.dart';
import 'ReplyOptionAction/ReplyOptionActionBottomSheet.dart';
import 'ReviewCountMediator.dart';
import 'ReviewDeleteMediator.dart';
import 'ReviewInertMediator.dart';
import 'ReviewUpdateMediator.dart';

class BasicReViewsContentBar extends StatelessWidget {
  final FBallReplyResDto _fBallReplyResDto;
  final bool showChildReply;
  final bool canSubReplyInsert;
  final bool showEditBtn;
  final bool hasBoardLine;
  final bool hasBottomPadding;
  final ReviewInertMediator _reviewInertMediator;
  final ReviewCountMediator _reviewCountMediator;
  final ReviewDeleteMediator _reviewDeleteMediator;
  final ReviewUpdateMediator _reviewUpdateMediator;

  BasicReViewsContentBar(
      {Key key,
      FBallReplyResDto fBallReplyResDto,
      ReviewInertMediator reviewInertMediator,
      ReviewCountMediator reviewCountMediator,
      ReviewDeleteMediator reviewDeleteMediator,
      ReviewUpdateMediator reviewUpdateMediator,
      this.showChildReply,
      this.showEditBtn,
      this.canSubReplyInsert,
      this.hasBoardLine,
      this.hasBottomPadding})
      : _fBallReplyResDto = fBallReplyResDto,
        _reviewInertMediator = reviewInertMediator,
        _reviewCountMediator = reviewCountMediator,
        _reviewDeleteMediator = reviewDeleteMediator,
        _reviewUpdateMediator = reviewUpdateMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BasicReViewsContentBarViewModel(
            showChildReply: showChildReply,
            fBallReplyUseCaseInputPort: sl(),
            fireBaseAuthAdapterForUseCase: sl(),
            context: context,
            showEditBtn: showEditBtn,
            reviewCountMediator: _reviewCountMediator,
            reviewDeleteMediator: _reviewDeleteMediator,
            reviewInertMediator: _reviewInertMediator,
            reviewUpdateMediator: _reviewUpdateMediator,
            fBallReplyResDto: _fBallReplyResDto,
            maliciousReplyUseCase: sl()
        ),
        child:
            Consumer<BasicReViewsContentBarViewModel>(builder: (_, model, __) {
          return Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                if (canSubReplyInsert && !model._isDeleteReply) {
                  model.subReplyInsertOpen(context);
                }
              },
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(0, 16, 0, hasBottomPadding ? 16 : 0),
                key: Key(_fBallReplyResDto.replyUuid),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              model.isRootReply() ? 16 : 65, 0, 8, 0),
                          width: model.isRootReply() ? 38 : 24,
                          height: model.isRootReply() ? 38 : 24,
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
                                      fontSize: model.isRootReply() ? 14 : 12,
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
                        model._isShowEditButton
                            ? Container(
                                child: InkWell(
                                    onTap: () {
                                      model.showOptionButtonDialog();
                                    },
                                    child: Container(
                                      alignment: Alignment(0.0, -1.0),
                                      height: 52,
                                      width: 52,
                                      child: Icon(ForutonaIcon.pointdash,
                                          size: 20, color: Colors.black),
                                    )))
                            : Container()
                      ],
                    ),
                    model.isChildReplyOpen
                        ? ListView.builder(
                            padding: EdgeInsets.all(0),
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
                                  reviewCountMediator: _reviewCountMediator,
                                  reviewUpdateMediator: _reviewUpdateMediator,
                                  reviewInertMediator: _reviewInertMediator,
                                  reviewDeleteMediator: _reviewDeleteMediator,
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
                        bottom: BorderSide(
                            color:
                                hasBoardLine ? Color(0xffF4F4F6) : Colors.white,
                            width: hasBoardLine ? 1 : 0))),
              ),
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

class BasicReViewsContentBarViewModel extends ChangeNotifier
    implements ReviewDeleteMediatorComponent, ReviewUpdateMediatorComponent {
  final FBallReplyResDto fBallReplyResDto;
  final ReviewInertMediator _reviewInertMediator;
  final ReviewCountMediator _reviewCountMediator;
  final ReviewDeleteMediator _reviewDeleteMediator;
  final ReviewUpdateMediator _reviewUpdateMediator;
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final MaliciousReplyUseCaseInputPort _maliciousReplyUseCase;
  final BuildContext context;
  bool isChildReplyOpen = false;
  bool showChildReply;
  FBallReplyDisplayUtil _fBallReplyDisplayUtil;
  bool showEditBtn;

  BasicReViewsContentBarViewModel(
      {this.fBallReplyResDto,
      this.showChildReply,
      this.context,
      this.showEditBtn,
      FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort,
      FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      ReviewInertMediator reviewInertMediator,
      ReviewDeleteMediator reviewDeleteMediator,
      ReviewUpdateMediator reviewUpdateMediator,
      ReviewCountMediator reviewCountMediator,
      MaliciousReplyUseCaseInputPort maliciousReplyUseCase})
      : _reviewInertMediator = reviewInertMediator,
        _reviewCountMediator = reviewCountMediator,
        _reviewDeleteMediator = reviewDeleteMediator,
        _reviewUpdateMediator = reviewUpdateMediator,
        _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _maliciousReplyUseCase = maliciousReplyUseCase {
    _fBallReplyDisplayUtil = new FBallReplyDisplayUtil(this.fBallReplyResDto);
    initStateOpenReply();
    if (_reviewDeleteMediator != null) {
      _reviewDeleteMediator.registerComponent(this);
    }
    if (_reviewUpdateMediator != null) {
      _reviewUpdateMediator.registerComponent(this);
    }
  }

  void initStateOpenReply() {
    if (isChildReplyShow && !isChildReplyOpen) {
      toggleChildOpenState();
    }
  }

  get isChildReplyShow {
    if (fBallReplyResDto.childCount > 0 && showChildReply) {
      return true;
    } else {
      return false;
    }
  }

  String getEvaluationInformation() {
    if (fBallReplyResDto.deleteFlag) {
      return "";
    }
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

  bool hasValuationHistory() {
    if (fBallReplyResDto.deleteFlag) {
      return false;
    }
    return fBallReplyResDto.fballValuationResDto != null;
  }

  bool isIssueBall() =>
      fBallReplyResDto.ballUuid.ballType == FBallType.IssueBall;

  bool hasEvaluation() => fBallReplyResDto.fballValuationResDto.point > 0;

  String get userNickName {
    return _fBallReplyDisplayUtil.userNickName;
  }

  String get userProfilePictureUrl {
    return _fBallReplyDisplayUtil.userProfilePictureUrl;
  }

  String get replyText {
    return _fBallReplyDisplayUtil.replyText;
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
    PageWrap<FBallReplyResDto> pageDtos =
        await _fBallReplyUseCaseInputPort.reqFBallReply(
            reqDto, Pageable(page: 0, size: 99999, sort: "ReplySort,ASC"));
    return pageDtos.content;
  }

  String getDisplayWriteTime() {
    if (fBallReplyResDto.deleteFlag) {
      return "";
    }
    return TimeDisplayUtil.getCalcToStrFromNow(
        fBallReplyResDto.replyUploadDateTime);
  }

  void subReplyInsertOpen(BuildContext context) async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      await showModalBottomSheet(
          context: context,
          isDismissible: true,
          isScrollControlled: true,
          builder: (context) {
            return BasicReViewsInsert(
                ballUuid: fBallReplyResDto.ballUuid.ballUuid,
                reviewInertMediator: _reviewInertMediator,
                reviewCountMediator: _reviewCountMediator,
                parentFBallReplyResDto: fBallReplyResDto,
                autoFocus: true);
          });
      fBallReplyResDto.childFBallReplyResDto = await getSubReply();
      fBallReplyResDto.childCount =
          fBallReplyResDto.childFBallReplyResDto.length;
      notifyListeners();
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => J001View()));
    }
  }

  bool isRootReply() => fBallReplyResDto.replySort == 0;

  void showOptionButtonDialog() async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      String userUid = await _fireBaseAuthAdapterForUseCase.userUid();
      if (userUid == fBallReplyResDto.uid.uid) {
        await showDialog(
            context: context,
            child: ReplyOptionActionAlertDialogSheet(
              fBallReplyResDto: fBallReplyResDto,
              reviewDeleteMediator: _reviewDeleteMediator,
              reviewUpdateMediator: _reviewUpdateMediator,
            ));
      } else {
        await showDialog(
            context: context,
            child: OtherUserBallPopup(
              onReportMalicious: onReportMalicious,
            ));
      }
    }
  }

  bool get _isShowEditButton {
    return showEditBtn && !_isDeleteReply;
  }

  bool get _isDeleteReply {
    return fBallReplyResDto.deleteFlag;
  }

  @override
  onDeleted(FBallReplyResDto fBallReplyResDto) {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    if (_reviewDeleteMediator != null) {
      _reviewDeleteMediator.unregisterComponent(this);
    }
    if (_reviewUpdateMediator != null) {
      _reviewUpdateMediator.unregisterComponent(this);
    }
  }

  onReportMalicious(BuildContext context,MaliciousType replyMaliciousType) async {
    await _maliciousReplyUseCase.reportMaliciousReply(replyMaliciousType,fBallReplyResDto.replyUuid);

  }

  @override
  onUpdated(FBallReplyResDto fBallReplyResDto) {
    notifyListeners();
  }
}
