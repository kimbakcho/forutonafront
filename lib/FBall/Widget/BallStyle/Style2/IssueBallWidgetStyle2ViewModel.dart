import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';


class IssueBallWidgetStyle2ViewModel extends ChangeNotifier{
  UserBallResDto resDto;
  bool isAlive = true;

  IssueBallWidgetStyle2ViewModel(this.resDto){
    this.isAliveBall();
  }

  void isAliveBall(){
    isAlive =  this.resDto.activationTime.isAfter(DateTime.now());
    notifyListeners();
  }
}