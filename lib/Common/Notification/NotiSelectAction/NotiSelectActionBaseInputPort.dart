import 'package:flutter/cupertino.dart';

import 'Dto/ActionPayloadDto.dart';

abstract class NotiSelectActionBaseInputPort {
  action(ActionPayloadDto actionPayloadDto,BuildContext context);
}