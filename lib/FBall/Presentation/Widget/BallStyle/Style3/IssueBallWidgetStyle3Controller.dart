import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/BasicStyle/IssueBallBasicStyleControllerMixin.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style3/IssueBallWidgetStyle3ViewModel.dart';

class IssueBallWidgetStyle3Controller with IssueBallBasicStyleControllerMixin{

  IssueBallWidgetStyle3ViewModel viewModel;

  IssueBallWidgetStyle3Controller({@required BuildContext context,  @required this.viewModel}){
    this.context = context;
  }
}