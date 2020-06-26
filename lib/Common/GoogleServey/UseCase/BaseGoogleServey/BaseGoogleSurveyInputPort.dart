
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyOutput.dart';


abstract class BaseGoogleSurveyInputPort {
  void reqOpenGoogleSurvey(BaseGoogleSurveyOutput baseGoogleSurveyOutput);
  int maxDraw;

  String prize;

  DateTime lottery;

  String surveyUrl;

}