import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/Preference.dart';

class FBallReplyDisplayUtil {
  final FBallReplyResDto fBallReplyResDto;

  FBallReplyDisplayUtil(this.fBallReplyResDto);

  String get replyText {
    if (fBallReplyResDto.deleteFlag!) {
      return "삭제된 메시지 입니다";
    } else {
      return fBallReplyResDto.replyText!;
    }
  }

  String get userProfilePictureUrl {
    return fBallReplyResDto.userProfilePictureUrl!;
  }

  String get userNickName {
    return fBallReplyResDto.userNickName!;
  }
}
