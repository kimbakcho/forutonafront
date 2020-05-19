import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class BallModifyService {

  Future<bool> isCanModify(FBallResDto resDto);
  void showModifySelectDialog(BuildContext context,FBallResDto resDto);

}