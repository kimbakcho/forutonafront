import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetController.dart';

import 'BallStyle1WidgetInter.dart';

class BallStyle1ReFreshBallUtil {
  Future reFreshBallAndUiUpdate(List<BallStyle1Widget> ballWidgetLists,FBallResDto reFreshNeedBall,BallStyle1WidgetInter ballStyle1WidgetInter) async {
    var fBallTypeRepository = FBallTypeRepository.create(FBallType.IssueBall);
    var ballResDto = await fBallTypeRepository
        .selectBall(FBallReqDto(reFreshNeedBall.ballType, reFreshNeedBall.ballUuid));
    var indexWhere =
        ballWidgetLists
        .indexWhere((element) => element.getBallUuid() == ballResDto.ballUuid);
    if (!ballResDto.ballDeleteFlag) {
      ballWidgetLists[indexWhere] = BallStyle1Widget.create(ballResDto.ballType,
          BallStyle1WidgetController(ballResDto,ballStyle1WidgetInter));
    } else {
      ballWidgetLists.removeAt(indexWhere);
    }
  }
}