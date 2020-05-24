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

      //해당 부분 비동기 처리로 인해 User가 평가후 화면에서 빠르게 나올때  BackEnd에서 해당 데이터 처리 전에 데이터를 받아 올때
      //동기화 문제가 발생함. 그래서 reFreshNeedBall 에서 Client 에서 실행 한 값으로 Like disLike 추측 반영
      ballResDto.ballLikes = reFreshNeedBall.ballLikes;
      ballResDto.ballDisLikes =reFreshNeedBall.ballDisLikes;

      ballWidgetLists[indexWhere] = BallStyle1Widget.create(ballResDto.ballType,
          BallStyle1WidgetController(ballResDto,ballStyle1WidgetInter));

    } else {
      ballWidgetLists.removeAt(indexWhere);
    }
  }
}