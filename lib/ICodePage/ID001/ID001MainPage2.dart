import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage2ViewModel.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001MakerInfo.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001Map.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'ID001WidgetPart/ID001AppBar.dart';
import 'ID001WidgetPart/ID001TagList.dart';
import 'ID001WidgetPart/ID001TextContent.dart';
import 'ID001WidgetPart/ID001Title.dart';

class ID001MainPage2 extends StatefulWidget {
  final String _ballUuid;

  ID001MainPage2({String ballUuid}) : _ballUuid = ballUuid;

  @override
  _ID001MainPage2State createState() =>
      _ID001MainPage2State(ballUuid: _ballUuid);
}

class _ID001MainPage2State extends State<ID001MainPage2> {
  final String _ballUuid;

  _ID001MainPage2State({String ballUuid}) : _ballUuid = ballUuid;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001MainPage2ViewModel(
            ballUuid: _ballUuid, selectBallUseCaseInputPort: sl()),
        child: Consumer<ID001MainPage2ViewModel>(builder: (_, model, __) {
          return Stack(children: <Widget>[Scaffold(body: mainBody(model))]);
        }));
  }

  Widget mainBody(ID001MainPage2ViewModel model) {
    return model.isLoadBallFinish()
        ? Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: <Widget>[
                ID001AppBar(model: model),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      ID001Title(
                        ballTitle: model.getBallTitle(),
                        hits: model.getBallHits(),
                        makeTime: model.getMakeTime(),
                      ),
                      ID001TagList(ballUuid: model.getBallUuid()),
                      ID001Map(
                        ballPosition: model.getBallPosition(),
                        ballAddress: model.getBallAddress(),
                        mapMakerDescriptorContainer: sl(),
                        geoLocationUtilForeGroundUseCase: sl(),
                      ),
                      ID001MakerInfo(
                        userNickName: model.getMakerNickName(),
                        userProfileImageUrl: model.getMakerProfileUrl(),
                        userFollower: model.getMakerFollower(),
                        userInfluencePower: model.getMakerInfluencePower(),
                      ),
                      ID001TextContent(
                        content: model.getBallTextContent(),
                        makeTime: model.getBallMakeTime(),
                      )
                    ],
                  ),
                )
              ],
            ))
        : Container();
  }
}
