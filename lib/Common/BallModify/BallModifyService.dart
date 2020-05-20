import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/BallModify/Impl/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class BallModifyService {

  Future<bool> isCanModify(FBallResDto resDto);
  Future<CommonBallModifyWidgetResultType> showModifySelectDialog(BuildContext context,FBallResDto resDto);

}