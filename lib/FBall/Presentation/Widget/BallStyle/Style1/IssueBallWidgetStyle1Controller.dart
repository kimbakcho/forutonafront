import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/BasicStyle/IssueBallBasicStyleControllerMixin.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'IssueBallWidgetStyle1ViewModel.dart';

class IssueBallWidgetStyle1Controller with IssueBallBasicStyleControllerMixin{

  IssueBallWidgetStyle1ViewModel viewModel;

  IssueBallWidgetStyle1Controller({@required BuildContext context,  @required this.viewModel}){
    this.context = context;
    geoLocationUtilUseCaseInputPort.reqBallDistanceDisplayText(
        ballLatLng: LatLng(viewModel.issueBall.latitude,viewModel.issueBall.longitude),
        geoLocationUtilUseCaseOp: this.viewModel);
  }

}