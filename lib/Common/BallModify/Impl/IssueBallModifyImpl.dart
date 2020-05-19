import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:forutonafront/Common/BallModify/BallModifyService.dart';
import 'package:forutonafront/Common/BallModify/Impl/CommonBallModifyWidget.dart';
import 'package:forutonafront/Common/BallModify/Impl/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueBallModifyImpl implements BallModifyService {

  @override
  Future<bool> isCanModify(FBallResDto resDto) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if(resDto.uid == firebaseUser.uid){
      return true;
    }else {
      return false;
    }
  }

  @override
  void showModifySelectDialog(BuildContext context,FBallResDto resDto) async{
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
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_){
            return IM001MainPage(LatLng(resDto.latitude,resDto.longitude),
                resDto.placeAddress, resDto.ballUuid, IM001MainPageEnterMode.Update);
          }
        ));

    }else if(commandResult == CommonBallModifyWidgetResultType.Delete){

    }
  }



}