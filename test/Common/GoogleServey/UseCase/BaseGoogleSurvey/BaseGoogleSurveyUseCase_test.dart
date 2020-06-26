import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyOutput.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart';

import 'package:mockito/mockito.dart';
class MockBaseGoogleSurveyOutput extends Mock implements BaseGoogleSurveyOutput{
}
void main(){
  MockBaseGoogleSurveyOutput baseGoogleSurveyOutput;
  BaseGoogleSurveyInputPort baseGoogleSurveyInputPort;
  setUp((){
    baseGoogleSurveyInputPort =  BaseGoogleSurveyUseCase();
    baseGoogleSurveyOutput = MockBaseGoogleSurveyOutput();
  });

  test('서비스 제안 구글 설문지 요청 Output에 Url Open 메소드 호출 검증', () async {
    //arrange
    baseGoogleSurveyInputPort.surveyUrl = "https://forms.gle/Cw7zarnUAUjcByMX8";
    //act
    baseGoogleSurveyInputPort.reqOpenGoogleSurvey(baseGoogleSurveyOutput);
    //assert
    verify(baseGoogleSurveyOutput.openGoogleSurvey("https://forms.gle/Cw7zarnUAUjcByMX8"));
  });

}