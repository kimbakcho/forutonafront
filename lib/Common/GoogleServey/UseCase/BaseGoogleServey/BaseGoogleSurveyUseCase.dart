import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyOutput.dart';

class BaseGoogleSurveyUseCase implements BaseGoogleSurveyInputPort{

  @override
  DateTime lottery;

  @override
  int maxDraw;

  @override
  String prize;

  @override
  String surveyUrl;

  @override
  void reqOpenGoogleSurvey(BaseGoogleSurveyOutput baseGoogleSurveyOutput) {
    baseGoogleSurveyOutput.openGoogleSurvey(surveyUrl);
  }



}