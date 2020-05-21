import 'package:forutonafront/Common/BallModify/Impl/CommonBallModifyWidgetResultType.dart';

class ID001ResultPopDto {
  bool isNeedRefreshBall;
  CommonBallModifyWidgetResultType modifyWidgetResultType;
  String ballUuid;

  ID001ResultPopDto(
      this.isNeedRefreshBall, this.modifyWidgetResultType, this.ballUuid);
}