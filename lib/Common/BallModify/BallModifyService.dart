import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/BallModify/Impl/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';

abstract class BallModifyService {

  Future<bool> isCanModify(String ballUid);
  Future<CommonBallModifyWidgetResultType> showModifySelectDialog(BuildContext context,FBallType fBallType,String ballUuid);

}