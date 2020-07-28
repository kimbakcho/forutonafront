import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ActionPayloadDto.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ID001PayloadDto.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBall/IssueBall/IssueBallUseCaseInputPort.dart';

import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';

class ID001PageMoveAction implements PageMoveActionUseCaseInputPort {

  final IssueBallUseCaseInputPort _issueBallUseCaseInputPort;

  ID001PageMoveAction({
    @required IssueBallUseCaseInputPort issueBallUseCaseInputPort})
      :_issueBallUseCaseInputPort = issueBallUseCaseInputPort;

  @override
  movePage(ActionPayloadDto actionPayloadDto, BuildContext context) async {
    ID001PayloadDto id001payloadDto = ID001PayloadDto.fromJson(
        json.decode(actionPayloadDto.payload));

    FBallResDto selectBall = await _issueBallUseCaseInputPort.selectBall(
        ballUuid: id001payloadDto.ballUuid);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            ID001MainPage(issueBall: IssueBall.fromFBallResDto(selectBall))
    ));
  }

}