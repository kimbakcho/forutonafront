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
  Future reFreshBallAndUiUpdate(List<BallStyle2Widget> ballWidgetLists,UserBallResDto reFreshNeedContent,BallStyle2WidgetInter ballStyle2WidgetInter) async {
    FBallPlayerRepository _fBallPlayerRepository = FBallPlayerRepository();
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var userToPlayBall = await _fBallPlayerRepository.getUserToPlayBall(UserToPlayBallSelectReqDto(firebaseUser.uid,reFreshNeedContent.fballResDto.ballUuid));
    //해당 부분 비동기 처리로 인해 User가 평가후 화면에서 빠르게 나올때  BackEnd에서 해당 데이터 처리 전에 데이터를 받아 올때
    //동기화 문제가 발생함. 그래서 reFreshNeedBall 에서 Client 에서 실행 한 값으로 Like disLike 추측 반영
    userToPlayBall.fballResDto.ballLikes = reFreshNeedContent.fballResDto.ballLikes;
    userToPlayBall.fballResDto.ballDisLikes =reFreshNeedContent.fballResDto.ballDisLikes;
    var indexWhere =
    ballWidgetLists
        .indexWhere((element) => element.getBallUuid() == reFreshNeedContent.fballResDto.ballUuid);
    ballWidgetLists[indexWhere] =
        BallStyle2Widget.create(userToPlayBall.fballResDto.ballType,BallStyle2WidgetController(userToPlayBall,ballStyle2WidgetInter));
  }
}