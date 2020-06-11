import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/BallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Impl/IssueBallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style2/IssueBallWidgetStyle2Controller.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style3/IssueBallWidgetStyle3Controller.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class IssueBallWidgetStyle2ViewModel extends ChangeNotifier implements IssueBallUseCaseOutputPort,GeoLocationUtilUseCaseOutputPort{

  BuildContext context;
  IssueBall issueBall;

  String distanceDisplayText = "";

  IssueBallWidgetStyle2Controller controller;

  IssueBallWidgetStyle2ViewModel({@required this.context,@required FBallResDto userBallResDto}){
    issueBall = IssueBall.fromFBallResDto(userBallResDto);
    controller = IssueBallWidgetStyle2Controller(context: context,viewModel: this);
  }


  @override
  void onBallHit() {
    return null;
  }

  @override
  void onSelectBall(FBallResDto fBallResDto) {
    issueBall = IssueBall.fromFBallResDto(fBallResDto);
    notifyListeners();
  }

  @override
  void onDeleteBall() {
    issueBall.ballDeleteFlag = true;
    notifyListeners();
  }

  String getDistanceDisplayText(){
    if(issueBall.ballDeleteFlag){
      return "";
    }else {
      return distanceDisplayText;
    }
  }

  @override
  onBallDistanceDisplayText({String displayDistanceText}) {
    this.distanceDisplayText = displayDistanceText;
    notifyListeners();
  }

  @override
  void onInsertBall(FBallResDto resDto) {
    throw("here don't have action");
  }

  @override
  void onUpdateBall() {
    throw("here don't have action");
  }
}
