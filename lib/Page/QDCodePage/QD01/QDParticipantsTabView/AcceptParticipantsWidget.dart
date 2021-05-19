import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallAction/QuestBall/QuestBallActionUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallParticipateState.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestBallParticipantResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Page/QDCodePage/Value/QuestEnterUserMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ParticipantInfoBar.dart';

class AcceptParticipantsWidget extends StatelessWidget {

  final AcceptParticipantsWidgetController? controller;

  final FBallResDto fBallResDto;

  AcceptParticipantsWidget({required this.fBallResDto,this.controller});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AcceptParticipantsWidgetViewModel(fBallResDto: fBallResDto,controller: controller),
      child: Consumer<AcceptParticipantsWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            margin: EdgeInsets.only(top: 16),
            child: model.isLoaded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Text(
                          '참가중(${model.acceptParticipates.length})',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: const Color(0xff000000),
                            letterSpacing: -0.28,
                            fontWeight: FontWeight.w700,
                            height: 1.2142857142857142,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ListView.builder(
                        itemCount: model.acceptParticipates.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(16),
                            child: ParticipantInfoBar(
                                    questBallParticipantResDto:
                                        model.acceptParticipates[index]),
                          );
                        },
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.zero,
                      )
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}

class AcceptParticipantsWidgetViewModel extends ChangeNotifier {

  final FBallResDto fBallResDto;

  bool isLoaded = false;

  final AcceptParticipantsWidgetController? controller;

  QuestBallActionUseCaseInputPort _questBallActionUseCaseInputPort = sl();

  List<QuestBallParticipantResDto> acceptParticipates = [];

  late QuestEnterUserMode questEnterUserMode;

  AcceptParticipantsWidgetViewModel({required this.fBallResDto,this.controller}) {
    if(controller!= null){
      this.controller!._viewModel = this;
    }
    _load();
  }

  _load() async {
    isLoaded = false;
    notifyListeners();
    this.acceptParticipates =
        await _questBallActionUseCaseInputPort.getParticipates(
            fBallResDto.ballUuid!, QuestBallParticipateState.Accept);
    this.questEnterUserMode = await _questBallActionUseCaseInputPort
        .getQuestEnterUserMode(fBallResDto);
    isLoaded = true;
    notifyListeners();
  }


}
class AcceptParticipantsWidgetController {

  AcceptParticipantsWidgetViewModel? _viewModel;

  reLoad(){
    if(_viewModel != null){
      _viewModel!._load();
    }
  }

}
