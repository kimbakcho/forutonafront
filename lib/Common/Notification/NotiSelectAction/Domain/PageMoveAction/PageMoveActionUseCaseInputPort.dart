import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ActionPayloadDto.dart';

abstract class PageMoveActionUseCaseInputPort {
  movePage(ActionPayloadDto actionPayloadDto,BuildContext context);
}