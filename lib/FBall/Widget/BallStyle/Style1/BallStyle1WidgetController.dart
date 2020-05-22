import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetInter.dart';

class BallStyle1WidgetController {
  final FBallResDto fBallResDto;
  final BallStyle1WidgetInter _ballStyle1WidgetInter ;
  BallStyle1WidgetController(this.fBallResDto,this._ballStyle1WidgetInter);

  onRequestReFreshBall(FBallResDto fBallResDto){
    this._ballStyle1WidgetInter.onRequestReFreshBall(fBallResDto);
  }
}