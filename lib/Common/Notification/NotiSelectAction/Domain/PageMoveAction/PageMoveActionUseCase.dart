import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ActionPayloadDto.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/NotiSelectActionBaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotiSelectActionBaseInputPort)
class PageMoveActionUseCase implements NotiSelectActionBaseInputPort {

  PageMoveActionUseCase();

  @override
  action(ActionPayloadDto actionPayloadDto,BuildContext context) {
    var serviceAction = sl.get<PageMoveActionUseCaseInputPort>(instanceName: "PageMoveActionUseCaseInputPortFactory"
        ,param1: actionPayloadDto.serviceKey);
    serviceAction.movePage(actionPayloadDto,context);
  }

}