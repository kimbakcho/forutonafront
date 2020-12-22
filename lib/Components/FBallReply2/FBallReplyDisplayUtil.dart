import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/Preference.dart';


class FBallReplyDisplayUtil {
  final FBallReplyResDto fBallReplyResDto;

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
      return Preference.basicProfileImageUrl;
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