
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallAction/QuestBall/QuestBallActionUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'AcceptParticipantsWidget.dart';
import 'WaitParticipantsWidget.dart';

class QDParticipantsTabView extends StatelessWidget {

  final FBallResDto fBallResDto;


  QDParticipantsTabView({required this.fBallResDto, Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QDParticipantsTabViewViewModel(),
      child: Consumer<QDParticipantsTabViewViewModel>(
        builder: (_, model, child) {
          return Container(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                WaitParticipantsWidget(
                  fBallResDto: fBallResDto,
                  onParticipantAccept: (){
                    model.onParticipantAccept();
                  },
                ),
                AcceptParticipantsWidget(
                  fBallResDto: fBallResDto,
                  controller: model.acceptParticipantsWidgetController,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class QDParticipantsTabViewViewModel extends ChangeNotifier {

  final AcceptParticipantsWidgetController acceptParticipantsWidgetController = AcceptParticipantsWidgetController();

  void onParticipantAccept() {
    acceptParticipantsWidgetController.reLoad();
  }




}
