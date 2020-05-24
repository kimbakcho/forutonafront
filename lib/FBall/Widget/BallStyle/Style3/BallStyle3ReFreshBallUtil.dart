import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style1/FBallResForMarkerDto.dart';
import 'package:forutonafront/FBall/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2WidgetInter.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3WidgetController.dart';

import 'BallStyle3WidgetInter.dart';

class BallStyle3ReFreshBallUtil {
  Future reFreshBallAndUiUpdate(List<FBallResForMarker> ballWidgetLists,FBallResDto reFreshNeedBall,
      Function(FBallResForMarker resDto) ballSelectFunction,
      BallStyle3WidgetInter ballStyle3WidgetInter) async {
    var fBallTypeRepository = FBallTypeRepository.create(reFreshNeedBall.ballType);
    FBallReqDto fBallReqDto = FBallReqDto(reFreshNeedBall.ballType, reFreshNeedBall.ballUuid);
    var selectBall = await fBallTypeRepository.selectBall(fBallReqDto);
    var indexWhere = ballWidgetLists
        .indexWhere((element) => element.ballUuid == selectBall.ballUuid);
    if (selectBall.ballDeleteFlag) {
      if (ballWidgetLists.length >= 1) {
        ballWidgetLists[indexWhere - 1].isSelectBall = true;
      }
      ballWidgetLists.removeAt(indexWhere);
    } else {
      ballWidgetLists[indexWhere] = FBallResForMarker(true, ballSelectFunction,
          selectBall, BallStyle3WidgetController(selectBall, ballStyle3WidgetInter));
    }
  }
}