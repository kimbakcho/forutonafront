import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/QuestBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallState.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/UseCase/FBallValuationUseCase/FBallValuationUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/Value/LikeActionType.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteReqDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Components/DetailPage/DBallLikeButton.dart';
import 'package:forutonafront/Components/SliderDatePicker/date_time_formatter.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/QDCodePage/Value/QuestEnterUserMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'ActionSheet/RecruitParticipantsSheet/RecruitParticipantsSheet.dart';
import 'QuestBottomActionButton.dart';

class QuestBottomNavBar extends StatefulWidget {
  final FBallResDto fBallResDto;

  const QuestBottomNavBar({Key? key, required this.fBallResDto})
      : super(key: key);

  @override
  _QuestBottomNavBarState createState() => _QuestBottomNavBarState();
}

class _QuestBottomNavBarState extends State<QuestBottomNavBar>
    with SingleTickerProviderStateMixin {
  Ticker? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      setState(() {});
    });
    _ticker!.start();
  }

  @override
  void dispose() {
    _ticker!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          QuestBottomNavBarViewModel(fBallResDto: widget.fBallResDto),
      child: Consumer<QuestBottomNavBarViewModel>(
        builder: (context, model, child) {
          return Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: model.isLoaded
                ? Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Stack(
                        fit: StackFit.loose,
                        children: [
                          Center(
                            child: Row(
                              children: [
                                DBallLikeButton(
                                  icon: ForutonaIcon.like,
                                  color: Color(0xff007EFF),
                                  controller: model.likeButtonController,
                                  initCount: model.fBallResDto.ballLikes!,
                                  initMyCount: model.likeInitMyCount,
                                  onTab: () {
                                    model.likeVote();
                                  },
                                ),
                                DBallLikeButton(
                                  icon: ForutonaIcon.dislike,
                                  iconSize: 16,
                                  color: Color(0xffFF4F9A),
                                  controller: model.disLikeButtonController,
                                  initCount: model.fBallResDto.ballDisLikes!,
                                  initMyCount: model.disLikeInitMyCount,
                                  onTab: () {
                                    model.dislikeVote();
                                  },
                                )
                              ],
                            ),
                          ),
                          model.isShowTicketReceiveTime
                              ? Center(
                                  child: Container(
                                    width: 105,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Text(model.nextTicketTime,
                                        style: GoogleFonts.notoSans(
                                          fontSize: 18,
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      TextButton(
                          style: ButtonStyle(
                              alignment: Alignment.centerLeft,
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero)),
                          onPressed: () {
                            Fluttertoast.showToast(msg: "준비중 입니다.");
                          },
                          child: Icon(
                            ForutonaIcon.gift,
                            color: Colors.black,
                          )),
                      Spacer(),
                      Container(
                        child: Icon(Icons.access_time_sharp,
                            color: Color(0xff5C5D5F), size: 15),
                      ),
                      SizedBox(width: 8,),
                      Container(
                        child: Text(model.getBallRemainTime,
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xff5c5d5f),
                              letterSpacing: -0.28,
                              fontWeight: FontWeight.w700,
                              height: 1.2142857142857142,
                            )),
                      ),
                      SizedBox(width: 16,),
                      model.getActionBtn(context),
                      SizedBox(width: 16,)
                    ],
                  )
                : Container(),

          );
        },
      ),
    );
  }
}

class QuestBottomNavBarViewModel extends ChangeNotifier {
  SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort = sl();

  FBallValuationUseCaseInputPort _fBallValuationUseCaseInputPort = sl();

  FBallResDto fBallResDto;

  bool isLoaded = false;

  bool syncLoadingFlag = false;

  DBallLikeButtonController likeButtonController = DBallLikeButtonController();

  late QuestBallDisPlayUseCase questBallDisPlayUseCase;

  DBallLikeButtonController disLikeButtonController =
      DBallLikeButtonController();

  late QuestEnterUserMode questEnterUserMode;

  late FBallVoteResDto fBallVoteResDto;

  int canUseTickCount = 0;

  QuestBottomNavBarViewModel({required this.fBallResDto}) {
    questBallDisPlayUseCase = QuestBallDisPlayUseCase(fBallResDto: fBallResDto);
    if (!_signInUserInfoUseCaseInputPort.isLogin!) {
      questEnterUserMode = QuestEnterUserMode.NoneLogin;
    } else if (fBallResDto.uid!.uid ==
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory()!.uid) {
      questEnterUserMode = QuestEnterUserMode.Maker;
    } else {
      questEnterUserMode = QuestEnterUserMode.Participant;
    }
    _load();
  }

  int get likeInitMyCount {
    if (this.questEnterUserMode == QuestEnterUserMode.NoneLogin) {
      return 0;
    } else {
      return fBallVoteResDto.ballLike!;
    }
  }

  int get disLikeInitMyCount {
    if (this.questEnterUserMode == QuestEnterUserMode.NoneLogin) {
      return 0;
    } else {
      return fBallVoteResDto.ballDislike!;
    }
  }

  String get getBallRemainTime {
    return questBallDisPlayUseCase.remainTime();
  }

  void likeVote() async {
    if (questEnterUserMode != QuestEnterUserMode.NoneLogin) {
      fBallResDto.ballLikes = fBallResDto.ballLikes! + 1;
      fBallVoteResDto.ballLike = fBallVoteResDto.ballLike! + 1;
      likeButtonController.setCount(fBallResDto.ballLikes!);
      likeButtonController.setMyCount(fBallVoteResDto.ballLike!);
      canUseTickCount = canUseTickCount - 1;
      notifyListeners();
      FBallVoteReqDto fBallVoteReqDto = FBallVoteReqDto();
      fBallVoteReqDto.ballUuid = fBallResDto.ballUuid;
      fBallVoteReqDto.likePoint = 1;
      fBallVoteReqDto.disLikePoint = 0;
      fBallVoteReqDto.likeActionType = LikeActionType.Vote;
      fBallVoteResDto =
          await _fBallValuationUseCaseInputPort.ballVote(fBallVoteReqDto);
      await syncUserInfo();
    } else {}
    notifyListeners();
  }

  void dislikeVote() async {
    if (questEnterUserMode != QuestEnterUserMode.NoneLogin) {
      fBallResDto.ballDisLikes = fBallResDto.ballDisLikes! + 1;
      fBallVoteResDto.ballDislike = fBallVoteResDto.ballDislike! + 1;
      disLikeButtonController.setCount(fBallResDto.ballDisLikes!);
      disLikeButtonController.setMyCount(fBallVoteResDto.ballDislike!);
      canUseTickCount = canUseTickCount - 1;
      FBallVoteReqDto fBallVoteReqDto = FBallVoteReqDto();
      fBallVoteReqDto.ballUuid = fBallResDto.ballUuid;
      fBallVoteReqDto.likePoint = 0;
      fBallVoteReqDto.disLikePoint = 1;
      fBallVoteReqDto.likeActionType = LikeActionType.Vote;
      fBallVoteResDto =
          await _fBallValuationUseCaseInputPort.ballVote(fBallVoteReqDto);
      notifyListeners();
      await syncUserInfo();
    } else {}
    notifyListeners();
  }

  void _load() async {
    isLoaded = false;
    notifyListeners();
    if (questEnterUserMode != QuestEnterUserMode.NoneLogin) {
      fBallVoteResDto = await _fBallValuationUseCaseInputPort
          .getBallVoteState(fBallResDto.ballUuid!);
      await syncUserInfo();
      var fUserInfoResDto =
          _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
      canUseTickCount = fUserInfoResDto!.influenceTicket!;
    }
    isLoaded = true;
    notifyListeners();
  }

  bool get isShowTicketReceiveTime {
    if (questEnterUserMode != QuestEnterUserMode.NoneLogin) {
      if (canUseTickCount <= 0) {
        var fUserInfoResDto =
            _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
        if (fUserInfoResDto!.nextGiveInfluenceTicketTime!
            .isAfter(DateTime.now())) {
          return true;
        }
      }
    }
    return false;
  }

  String get nextTicketTime {
    if (isShowTicketReceiveTime) {
      var fUserInfoResDto =
          _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
      var difference = fUserInfoResDto!.nextGiveInfluenceTicketTime!
          .difference(DateTime.now());
      String timeStr =
          "${difference.inMinutes.remainder(60).toString().padLeft(2, "0")}:${(difference.inSeconds.remainder(60).toString().padLeft(2, "0"))}";
      return timeStr;
    } else {
      return "";
    }
  }

  syncUserInfo() async {
    syncLoadingFlag = true;
    if (_signInUserInfoUseCaseInputPort.isLogin!) {
      await _signInUserInfoUseCaseInputPort
          .saveSignInInfoInMemoryFromAPiServer();
      notifyListeners();
    }
    syncLoadingFlag = false;
  }

  Widget getActionBtn(BuildContext context){
    if(this.questEnterUserMode == QuestEnterUserMode.NoneLogin){
      return QuestBottomActionButton(
        color: Color(0xff007EFF),
        text: "참가하기",
        backGroundColor: Color(0xffE5F2FF),
      );
    }else if(questEnterUserMode == QuestEnterUserMode.Maker){
      if(fBallResDto.ballState == FBallState.Wait){
        return QuestBottomActionButton(
          color: Color(0xffFF4F9A),
          text: "참가자 모집",
          backGroundColor: Color(0xffFFF1FD),
          onTap: (){
            showMaterialModalBottomSheet(context: context, builder: (context) {
              return RecruitParticipantsSheet();
            },


                enableDrag: true,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
            );
          },
        );
      }else if(fBallResDto.ballState == FBallState.Play){
        return QuestBottomActionButton(
          color: Color(0xffFF4F9A),
          text: "매니저 모드",
          backGroundColor: Color(0xffFFF1FD),
        );
      }else if(fBallResDto.ballState == FBallState.Finish){
        return QuestBottomActionButton(
          color: Color(0xffFF4F9A),
          text: "퀘스트 결과",
          backGroundColor: Color(0xffFFF1FD),
        );
      }
    }else if(questEnterUserMode == QuestEnterUserMode.Participant){
      if(fBallResDto.ballState == FBallState.Play){
        return QuestBottomActionButton(
          color: Color(0xff007EFF),
          text: "참가하기",
          backGroundColor: Color(0xffE5F2FF),
        );
      }else if(fBallResDto.ballState == FBallState.Finish){
        return QuestBottomActionButton(
          color: Color(0xff007EFF),
          text: "퀘스트 결과",
          backGroundColor: Color(0xffE5F2FF),
        );
      }
    }
    return Container();
  }
}
