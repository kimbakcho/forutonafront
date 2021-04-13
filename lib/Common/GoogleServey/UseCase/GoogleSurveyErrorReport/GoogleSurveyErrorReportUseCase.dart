import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart';
import 'package:injectable/injectable.dart';


class GoogleSurveyErrorReportUseCase extends BaseGoogleSurveyUseCase {
  GoogleSurveyErrorReportUseCase() {
    this.prize = "한우셋트";
    this.lottery = DateTime(2021, 05, 20);
    this.maxDraw = 10;
    this.surveyUrl = "https://forms.gle/Cw7zarnUAUjcByMX8";
  }
}
