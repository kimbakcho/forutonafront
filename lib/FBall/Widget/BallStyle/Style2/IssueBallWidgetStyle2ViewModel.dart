import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/BallModify/BallModifyService.dart';

import 'package:forutonafront/Common/BallModify/Impl/IssueBallModifyImpl.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2WidgetController.dart';
import 'package:forutonafront/ICodePage/ID001/Dto/ID001ResultPopDto.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';


class IssueBallWidgetStyle2ViewModel extends ChangeNotifier{

  bool isAlive = true;
  BuildContext _context;
  final BallStyle2WidgetController ballStyle2WidgetController;

  IssueBallWidgetStyle2ViewModel(this.ballStyle2WidgetController,this._context){
    this.isAliveBall();
  }

  UserBallResDto getUserBallResDto(){
    return this.ballStyle2WidgetController.userBallResDto;
  }

  isBallDelete(){
    return getUserBallResDto().fballResDto.ballDeleteFlag;
  }

  void isAliveBall(){
    isAlive =  getUserBallResDto().fballResDto.activationTime.isAfter(DateTime.now());
    notifyListeners();
  }

  void goIssueDetailPage() async {
    if(isBallDelete()){
      Fluttertoast.showToast(
          msg: "삭제된 Ball 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }else {
      await Navigator.of(_context)
          .push(MaterialPageRoute(builder: (_) => ID001MainPage(getUserBallResDto().fballResDto.ballUuid,fBallResDto: getUserBallResDto().fballResDto)));
      this.ballStyle2WidgetController.onRequestReFreshBall(getUserBallResDto());
    }
  }
  void showBallSetting() async {

    BallModifyService ballModifyService = IssueBallModifyImpl();
    if (await ballModifyService.isCanModify(getUserBallResDto().fballResDto.ballUuid)) {
      var result =
      await ballModifyService.showModifySelectDialog(_context, getUserBallResDto().fballResDto.ballType,getUserBallResDto().fballResDto.ballUuid);
      this.ballStyle2WidgetController.onRequestReFreshBall(getUserBallResDto());
    }
  }
}