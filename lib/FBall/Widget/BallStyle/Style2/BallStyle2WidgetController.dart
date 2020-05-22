import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2WidgetInter.dart';

class BallStyle2WidgetController {
  final UserBallResDto userBallResDto;
  final BallStyle2WidgetInter _ballStyle2WidgetInter ;
  BallStyle2WidgetController(this.userBallResDto,this._ballStyle2WidgetInter);

  onRequestReFreshBall(UserBallResDto userBallResDto){
    this._ballStyle2WidgetInter.onRequestReFreshBall(userBallResDto);
  }

}