import 'package:flutter/material.dart';
import 'package:forutonafront/Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyOutput.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkOutputPort.dart';

class KT001PageViewModel with ChangeNotifier implements BaseOpenTalkOutputPort,BaseGoogleSurveyOutput {
  final BaseOpenTalkInputPort _inquireAboutAnythingUseCase;
  final AndroidIntentAdapter _androidIntentAdapter;
  final BaseGoogleSurveyInputPort _errorReportSurvey;
  final BaseGoogleSurveyInputPort _proposalOnServiceSurvey;

  KT001PageViewModel({
    @required BaseOpenTalkInputPort inquireAboutAnythingUseCase,
    @required AndroidIntentAdapter androidIntentAdapter,
    @required BaseGoogleSurveyInputPort errorReportSurvey,
    @required BaseGoogleSurveyInputPort proposalOnServiceSurvey,
  })  : _inquireAboutAnythingUseCase = inquireAboutAnythingUseCase,
        _androidIntentAdapter = androidIntentAdapter,
        _errorReportSurvey = errorReportSurvey,
        _proposalOnServiceSurvey = proposalOnServiceSurvey ;


  void inquireAboutAnythingClick() {
    _inquireAboutAnythingUseCase.reqOpenLinkTalk(this);
  }

  void errorReportSurveyClick(){
    _errorReportSurvey.reqOpenGoogleSurvey(this);
  }

  @override
  openKakaoOpenTalk(String openTalkUrl) async {
    _androidIntentAdapter.createIntent(
        action: "action_view", data: openTalkUrl);
    _androidIntentAdapter.launch();
  }

  get errorReportMaxDraw{
    return _errorReportSurvey.maxDraw;
  }
  get errorReportPrize{
    return _errorReportSurvey.prize;
  }
  get errorReportLotteryMonth{
    return _errorReportSurvey.lottery.month;
  }
  get errorReportLotteryDay{
    return _errorReportSurvey.lottery.day;
  }

  get proposalOnServiceMaxDraw{
    return _proposalOnServiceSurvey.maxDraw;
  }
  get proposalOnServicePrize{
    return _proposalOnServiceSurvey.prize;
  }
  get proposalOnServiceLotteryMonth{
    return _proposalOnServiceSurvey.lottery.month;
  }
  get proposalOnServiceLotteryDay{
    return _proposalOnServiceSurvey.lottery.day;
  }

  @override
  openGoogleSurvey(String surveyUrl) {
    _androidIntentAdapter.createIntent(
        action: "action_view", data: surveyUrl);
    _androidIntentAdapter.launch();
  }

  void proposalOnServiceClick()async {
    _proposalOnServiceSurvey.reqOpenGoogleSurvey(this);

  }
}
