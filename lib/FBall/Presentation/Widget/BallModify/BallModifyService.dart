import 'package:flutter/cupertino.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/FBall/Data/Value/FBallType.dart';

import 'Widget/CommonBallModifyWidgetResultType.dart';

abstract class BallModifyService {

  Future<CommonBallModifyWidgetResultType> showModifySelectDialog({@required BuildContext context});

}