import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/BallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Impl/IssueBallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style2/IssueBallWidgetStyle2ViewModel.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class IssueBallWidgetStyle2Controller{

  BuildContext context;

  IssueBallWidgetStyle2ViewModel viewModel;

  IssueBallUseCaseInputPort issueBallUseCaseInputPort = IssueBallUseCase();

  GeoLocationUtilUseCaseInputPort geoLocationUtilUseCaseInputPort = GeoLocationUtilUseCase();

  IssueBallWidgetStyle2Controller({@required BuildContext context,  @required this.viewModel}){
    this.context = context;
    geoLocationUtilUseCaseInputPort.reqBallDistanceDisplayText
      (ballLatLng: LatLng(viewModel.issueBall.latitude,viewModel.issueBall.longitude),geoLocationUtilUseCaseOp: viewModel);
  }

  void goIssueDetailPage() async {
    if(viewModel.issueBall.ballDeleteFlag){
      Fluttertoast.showToast(
          msg: "삭제된 Ball 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }else {
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ID001MainPage(issueBall: viewModel.issueBall)));
      issueBallUseCaseInputPort.selectBall(ballUuid: viewModel.issueBall.ballUuid,outputPort: viewModel);
    }
  }

  void showBallSetting() async {
    BallModifyService ballModifyService = IssueBallModifyService();
    if (await viewModel.issueBall.isCanModify()) {
      CommonBallModifyWidgetResultType result = await ballModifyService
          .showModifySelectDialog(context: context);
      if (result == CommonBallModifyWidgetResultType.Update) {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) {
              return IM001MainPage(
                  LatLng(viewModel.issueBall.latitude, viewModel.issueBall.longitude),
                  viewModel.issueBall.placeAddress, viewModel.issueBall.ballUuid,
                  IM001MainPageEnterMode.Update);
            }
        ));
        issueBallUseCaseInputPort.selectBall(ballUuid: viewModel.issueBall.ballUuid, outputPort: viewModel);
      } else {
        issueBallUseCaseInputPort.deleteBall(ballUuid: viewModel.issueBall.ballUuid, outputPort: viewModel);
      }
    }
  }

}