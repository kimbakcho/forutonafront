import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/BallModify/BallModifyService.dart';
import 'package:forutonafront/Common/BallModify/Widget/CommonBallModifyWidget.dart';
import 'package:forutonafront/Common/BallModify/Widget/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueBallModifyImpl implements BallModifyService {

  @override
  Future<bool> isCanModify(String ballUid) async {
//    FBallTypeRepository fBallTypeRepository = FBallTypeRepository.create(FBallType.IssueBall);
//    var fBallResDto = await fBallTypeRepository.selectBall(FBallReqDto(fBallType,ballUuid));
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if(ballUid == firebaseUser.uid){
      return true;
    }else {
      return false;
    }
  }

  @override
  Future<CommonBallModifyWidgetResultType> showModifySelectDialog(BuildContext context,FBallType fBallType,String ballUuid) async{

    FBallTypeRepository fBallTypeRepository = FBallTypeRepository.create(FBallType.IssueBall);
    CommonBallModifyWidgetResultType commandResult = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return CommonBallModifyWidget();
        });
    if(commandResult == CommonBallModifyWidgetResultType.Update){
      var fBallResDto = await fBallTypeRepository.selectBall(FBallReqDto(fBallType,ballUuid));
        var result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (_){
            return IM001MainPage(LatLng(fBallResDto.latitude,fBallResDto.longitude),
                fBallResDto.placeAddress, fBallResDto.ballUuid, IM001MainPageEnterMode.Update);
          }
        ));
        if(result != null && result == IM001MainPageEnterMode.Update){
          return CommonBallModifyWidgetResultType.Update;
        }
    }else if(commandResult == CommonBallModifyWidgetResultType.Delete){
      FBallReqDto reqDto = new FBallReqDto(FBallType.IssueBall, ballUuid);
      await fBallTypeRepository.deleteBall(reqDto);
      return CommonBallModifyWidgetResultType.Delete;
    }
    return null;
  }



}