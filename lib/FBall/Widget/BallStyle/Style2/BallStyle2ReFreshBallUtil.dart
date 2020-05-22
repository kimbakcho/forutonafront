import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallSelectReqDto.dart';
import 'package:forutonafront/FBall/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetController.dart';


import 'BallStyle2Widget.dart';
import 'BallStyle2WidgetController.dart';
import 'BallStyle2WidgetInter.dart';

class BallStyle2ReFreshBallUtil {
  Future reFreshBallAndUiUpdate(List<BallStyle2Widget> ballWidgetLists,UserBallResDto reFreshNeedBall,BallStyle2WidgetInter ballStyle2WidgetInter) async {
    FBallPlayerRepository _fBallPlayerRepository = FBallPlayerRepository();
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var userToPlayBall = await _fBallPlayerRepository.getUserToPlayBall(UserToPlayBallSelectReqDto(firebaseUser.uid,reFreshNeedBall.fBallUuid));
    var indexWhere =
    ballWidgetLists
        .indexWhere((element) => element.getBallUuid() == reFreshNeedBall.fBallUuid);
    ballWidgetLists[indexWhere] =
        BallStyle2Widget.create(userToPlayBall.fBallType,BallStyle2WidgetController(userToPlayBall,ballStyle2WidgetInter));
  }
}