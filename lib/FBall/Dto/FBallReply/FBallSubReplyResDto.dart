
import 'FBallReplyResDto.dart';

class FBallSubReplyResDto extends FBallReplyResDto{

  FBallSubReplyResDto();

  factory FBallSubReplyResDto.fromFBallReplyResDto(FBallReplyResDto mainReplyitem){
    FBallSubReplyResDto ballSubReplyResDto = FBallSubReplyResDto();
    ballSubReplyResDto.replySort = mainReplyitem.replySort;
    ballSubReplyResDto.replyUploadDateTime = mainReplyitem.replyUploadDateTime;
    ballSubReplyResDto.replyNumber = mainReplyitem.replyNumber;
    ballSubReplyResDto.replyText = mainReplyitem.replyText;
    ballSubReplyResDto.userNickName = mainReplyitem.userNickName;
    ballSubReplyResDto.replyDepth = mainReplyitem.replyDepth;
    ballSubReplyResDto.replyUuid =mainReplyitem.replyUuid;
    ballSubReplyResDto.ballUuid = mainReplyitem.ballUuid;
    ballSubReplyResDto.uid = mainReplyitem.uid;
    ballSubReplyResDto.userProfilePictureUrl = mainReplyitem.userProfilePictureUrl;
    ballSubReplyResDto.replyOpenFlag = false;
    ballSubReplyResDto.replyUpdateDateTime = mainReplyitem.replyUpdateDateTime;
    ballSubReplyResDto.deleteFlag = mainReplyitem.deleteFlag;
    return ballSubReplyResDto;
  }
  //Reply Detail 화면에서 펼치기 상태를 저장하기 위해서 사용
  bool replyOpenFlag = false;
  //대댓글들
  List<FBallReplyResDto> subReply = [];

}