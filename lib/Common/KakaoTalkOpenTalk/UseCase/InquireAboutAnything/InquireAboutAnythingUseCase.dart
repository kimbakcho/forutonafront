import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkOutputPort.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BaseOpenTalkInputPort)
class InquireAboutAnythingUseCase implements BaseOpenTalkInputPort {
  @override
  void reqOpenLinkTalk(BaseOpenTalkOutputPort outputPort) {
    String openTalkUrl = "https://open.kakao.com/o/sUFJMxqb";
    outputPort.openKakaoOpenTalk(openTalkUrl);
  }
}