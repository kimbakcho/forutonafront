import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart';
import 'package:injectable/injectable.dart';

@named
@Injectable(as: BaseGoogleSurveyInputPort)
class GoogleProposalOnServiceSurveyUseCase extends BaseGoogleSurveyUseCase {
  GoogleProposalOnServiceSurveyUseCase(){
    this.prize = "한우셋트1";
    this.lottery = DateTime(2020,08,20);
    this.maxDraw = 20;
    this.surveyUrl = "https://forms.gle/Cw7zarnUAUjcByMX8";
  }
}