import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';
import 'package:forutonafront/ICodePage/ID001/Dto/ID001ResultPopDto.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';


class IssueBallWidgetStyle2ViewModel extends ChangeNotifier{
  UserBallResDto resDto;
  bool isAlive = true;
  BuildContext _context;
  final Function(UserBallResDto) onRequestReFreshBall;
  IssueBallWidgetStyle2ViewModel(this.resDto,this._context,this.onRequestReFreshBall){
    this.isAliveBall();
  }

  isBallDelete(){
    return resDto.ballDeleteFlag;
  }

  void isAliveBall(){
    isAlive =  this.resDto.activationTime.isAfter(DateTime.now());
    notifyListeners();
  }

  void goIssueDetailPage() async {
    if(resDto.ballDeleteFlag){
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
          .push(MaterialPageRoute(builder: (_) => ID001MainPage(resDto.fBallUuid)));
      this.onRequestReFreshBall(resDto);
    }

  }
}