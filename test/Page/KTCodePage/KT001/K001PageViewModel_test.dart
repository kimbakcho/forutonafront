import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/GoogleProposalOnServiceSurvey/GoogleProposalOnServiceSurveyUseCase.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/GoogleSurveyErrorReport/GoogleSurveyErrorReportUseCase.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkOutputPort.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/InquireAboutAnything/InquireAboutAnythingUseCase.dart';
import 'package:forutonafront/Page/KTCodePage/KT001/KT001PageViewModel.dart';


import 'package:mockito/mockito.dart';

class MockInquireAboutAnythingUseCase extends Mock
    implements InquireAboutAnythingUseCase {}

class MockBaseOpenTalkOutputPort extends Mock
    implements BaseOpenTalkOutputPort {}

class MockAndroidIntentAdapter extends Mock implements AndroidIntentAdapter {}

class MockGoogleSurveyErrorReportUseCase extends Mock
    implements GoogleSurveyErrorReportUseCase {}

class MockGoogleProposalOnServiceSurveyUseCase extends Mock
    implements GoogleProposalOnServiceSurveyUseCase {}

void main() {
  BaseOpenTalkInputPort mockInquireAboutAnythingUseCase;

  MockAndroidIntentAdapter mockAndroidIntentAdapter;
  MockGoogleSurveyErrorReportUseCase mockGoogleSurveyErrorReportUseCase;
  MockGoogleProposalOnServiceSurveyUseCase
      mockGoogleProposalOnServiceSurveyUseCase;

  KT001PageViewModel kt001pageViewModel;
  setUp(() {
    mockInquireAboutAnythingUseCase = MockInquireAboutAnythingUseCase();

    mockAndroidIntentAdapter = MockAndroidIntentAdapter();
    mockGoogleSurveyErrorReportUseCase = MockGoogleSurveyErrorReportUseCase();
    mockGoogleProposalOnServiceSurveyUseCase =
        MockGoogleProposalOnServiceSurveyUseCase();

    kt001pageViewModel = KT001PageViewModel(
        inquireAboutAnythingUseCase: mockInquireAboutAnythingUseCase,
        androidIntentAdapter: mockAndroidIntentAdapter,
        errorReportSurvey: mockGoogleSurveyErrorReportUseCase,
        proposalOnServiceSurvey: mockGoogleProposalOnServiceSurveyUseCase);
  });

  test('카카오톡 오픈 링크 URL 요청', () async {
    //arrange
    //act
    kt001pageViewModel.inquireAboutAnythingClick();
    //assert
    verify(mockInquireAboutAnythingUseCase
        .reqOpenLinkTalk(kt001pageViewModel));
  });

  test('카카오톡 오픈 Url Intent 요청 메소드 실행 검증', () async {
    //arrange

    //act
    kt001pageViewModel.openKakaoOpenTalk("test");
    //assert
    verify(mockAndroidIntentAdapter.createIntent(
        action: "action_view", data: "test"));
  });

  test('오류신고 Url 요청 메소드 실행 검증', () async {
    //arrange

    //act
    kt001pageViewModel.errorReportSurveyClick();
    //assert
    verify(mockGoogleSurveyErrorReportUseCase.reqOpenGoogleSurvey(kt001pageViewModel));
  });

  test('오류신고 Url Intent 출력시 Intent 실행 검증 ', () async {
    //arrange

    //act
    kt001pageViewModel.openGoogleSurvey("test");
    //assert
    //assert
    verify(mockAndroidIntentAdapter.createIntent(
        action: "action_view", data: "test"));
  });

  test('서비스 의견 제안하기 버튼 클릭시 Url 요청 검증  ', () async {
    //arrange

    //act
    kt001pageViewModel.proposalOnServiceClick();
    //assert
    verify(mockGoogleProposalOnServiceSurveyUseCase.reqOpenGoogleSurvey(kt001pageViewModel));
  });

  test('서비스 의견 제안하기 버튼 클릭시 Url Intent 출력시 Intent 실행 검증 ', () async {
    //arrange

    //act
    kt001pageViewModel.openGoogleSurvey("service");
    //assert
    //assert
    verify(mockAndroidIntentAdapter.createIntent(
        action: "action_view", data: "service"));
  });

}
