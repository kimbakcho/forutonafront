import 'package:flutter/cupertino.dart';

import 'Widget/CommonBallModifyWidgetResultType.dart';

abstract class BallModifyService {
  Future<CommonBallModifyWidgetResultType> showModifySelectDialog({@required BuildContext context});
}