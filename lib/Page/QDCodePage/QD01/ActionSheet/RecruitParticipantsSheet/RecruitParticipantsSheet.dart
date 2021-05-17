import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallAction/QuestBall/QuestBallActionUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallDescription.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/RecruitParticipantReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'QualifyingForQuestTextWidget.dart';
import 'RecruitParticipantsAppBar.dart';

class RecruitParticipantsSheet extends StatelessWidget {

  final FBallResDto fBallResDto;

  RecruitParticipantsSheet({required this.fBallResDto});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecruitParticipantsSheetViewModel(
        fBallResDto: fBallResDto
      ),
      child: Consumer<RecruitParticipantsSheetViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(width: 1, color: Color(0xffE4E7E8)))),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  CircleIconBtn(
                    height: 42,
                    width: 42,
                    isBoxShadow: false,
                    color: Color(0xffF6F6F6),
                    icon: Icon(ForutonaIcon.trophy1,size: 16,),
                    onTap: (){
                      Fluttertoast.showToast(msg: "준비 중 입니다.");
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  CircleIconBtn(
                    height: 42,
                    width: 42,
                    isBoxShadow: false,
                    color: Color(0xffF6F6F6),
                    icon: Icon(ForutonaIcon.credit_card1,size: 16,),
                    onTap: (){
                      Fluttertoast.showToast(msg: "준비 중 입니다.");
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  CircleIconBtn(
                    height: 42,
                    width: 42,
                    isBoxShadow: false,
                    color: Color(0xffF6F6F6),
                    icon: Icon(ForutonaIcon.lock1,size: 16,),
                    onTap: (){
                      Fluttertoast.showToast(msg: "준비 중 입니다.");
                    },
                  ),
                ],
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).padding.right,
                  MediaQuery.of(context).padding.top + 10,
                  MediaQuery.of(context).padding.right,
                  MediaQuery.of(context).padding.bottom),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.white),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        RecruitParticipantsAppBar(
                          controller: model._recruitParticipantsAppBarController,
                          onComplete: (){
                            model.complete(context);
                          }
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: QualifyingForQuestTextWidget(
                            controller: model._qualifyingForQuestTextWidgetController,
                            onChange: (value){
                              model._checkComplete();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecruitParticipantsSheetViewModel extends ChangeNotifier {

  final FBallResDto fBallResDto;

  RecruitParticipantsAppBarController _recruitParticipantsAppBarController = RecruitParticipantsAppBarController();

  QualifyingForQuestTextWidgetController _qualifyingForQuestTextWidgetController = QualifyingForQuestTextWidgetController();

  QuestBallActionUseCaseInputPort _questBallActionUseCaseInputPort = sl();

  RecruitParticipantsSheetViewModel({required this.fBallResDto});

  _checkComplete(){
    if(_qualifyingForQuestTextWidgetController.getText().isNotEmpty){
      _recruitParticipantsAppBarController.setIsCanComplete(true);
    }else {
      _recruitParticipantsAppBarController.setIsCanComplete(false);
    }
  }

  complete(BuildContext context) async {

    showDialog(context: context, builder: (context) {
      return CommonLoadingComponent();
    });

    var questBallDescription = QuestBallDescription.fromJson(json.decode(fBallResDto.description!));
    questBallDescription.qualifyingForQuestText = _qualifyingForQuestTextWidgetController.getText();
    RecruitParticipantReqDto reqDto = RecruitParticipantReqDto();
    reqDto.ballUuid = fBallResDto.ballUuid;
    reqDto.qualifyingForQuestText = _qualifyingForQuestTextWidgetController.getText();
    var fBallResDto2 = await _questBallActionUseCaseInputPort.recruitParticipants(reqDto);

    this.fBallResDto.description = fBallResDto2.description;
    this.fBallResDto.ballState = fBallResDto2.ballState;

    Navigator.of(context).pop();
    Navigator.of(context).pop();

  }

}
