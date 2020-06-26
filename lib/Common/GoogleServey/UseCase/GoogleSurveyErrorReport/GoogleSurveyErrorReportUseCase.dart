import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart';

class GoogleSurveyErrorReportUseCase extends BaseGoogleSurveyUseCase {
  GoogleSurveyErrorReportUseCase() {
    this.prize = "한우셋트2";
    this.lottery = DateTime(2020, 09, 20);
    this.maxDraw = 10;
    this.surveyUrl = "https://forms.gle/Cw7zarnUAUjcByMX8";
  }
}
