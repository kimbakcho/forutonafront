import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkOutputPort.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/InquireAboutAnything/InquireAboutAnythingUseCase.dart';
import 'package:mockito/mockito.dart';

class MockBaseOpenTalkOutputPort extends Mock
    implements BaseOpenTalkOutputPort {}

void main() {
  MockBaseOpenTalkOutputPort mockBaseOpenTalkOutputPort;
  setUp(() {
    mockBaseOpenTalkOutputPort = new MockBaseOpenTalkOutputPort();
  });

  test('카카오톡 오픈 톡 주소 요청시 Output Port 로 출력 ', () async {
    //arrange
    BaseOpenTalkInputPort inquireAboutAnythingUseCase =
        new InquireAboutAnythingUseCase();
    //act
    inquireAboutAnythingUseCase.reqOpenLinkTalk(mockBaseOpenTalkOutputPort);
    //assert
    verify(mockBaseOpenTalkOutputPort
        .openKakaoOpenTalk("https://open.kakao.com/o/sUFJMxqb"));
  });
}
