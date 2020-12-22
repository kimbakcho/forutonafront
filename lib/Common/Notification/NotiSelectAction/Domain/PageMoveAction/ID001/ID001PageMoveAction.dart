import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ActionPayloadDto.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ID001PayloadDto.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PageMoveActionUseCaseInputPort)
class ID001PageMoveAction implements PageMoveActionUseCaseInputPort {

  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;

  ID001PageMoveAction({
    @required SelectBallUseCaseInputPort selectBallUseCaseInputPort})
      :_selectBallUseCaseInputPort = selectBallUseCaseInputPort;

  @override
  movePage(ActionPayloadDto actionPayloadDto, BuildContext context) async {
    ID001PayloadDto id001payloadDto = ID001PayloadDto.fromJson(
        json.decode(actionPayloadDto.payload));

    await _selectBallUseCaseInputPort.selectBall(id001payloadDto.ballUuid);

//    Navigator.of(context).push(MaterialPageRoute(
//        builder: (_) =>
//            ID001MainPage(selectBall)
//    ));
  }

}