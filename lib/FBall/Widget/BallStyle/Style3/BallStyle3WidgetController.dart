import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3WidgetInter.dart';

class BallStyle3WidgetController {
  final FBallResDto fBallResDto;
  final BallStyle3WidgetInter _ballStyle3WidgetInter;
  BallStyle3WidgetController(this.fBallResDto,this._ballStyle3WidgetInter);

  onRequestReFreshBall(FBallResDto fBallResDto){
    this._ballStyle3WidgetInter.onRequestReFreshBall(fBallResDto);
  }

}