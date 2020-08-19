import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class FBallReplyDisplayUtil {
  final FBallReplyResDto fBallReplyResDto;
  final Preference preference = sl();

  FBallReplyDisplayUtil(this.fBallReplyResDto);

  String get replyText {
    if(fBallReplyResDto.deleteFlag) {
      return "삭제됨";
    }else {
      return fBallReplyResDto.replyText;
    }
  }

  String get userProfilePictureUrl {
    if(fBallReplyResDto.deleteFlag){
      return preference.basicProfileImageUrl;
    }else {
      return fBallReplyResDto.userProfilePictureUrl;
    }
  }

  String get userNickName {
    if(fBallReplyResDto.deleteFlag){
      return "";
    }else {
      return fBallReplyResDto.userNickName;
    }
  }


}