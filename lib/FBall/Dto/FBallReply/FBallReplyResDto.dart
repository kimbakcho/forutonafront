import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallReplyResDto.g.dart';

@JsonSerializable()
class FBallReplyResDto {
  String replyUuid;
  String ballUuid;
  String uid;
  int replyNumber;
  int replySort;
  int replyDepth;
  String replyText;
  DateTime replyUploadDateTime;
  DateTime replyUpdateDateTime;
  String userNickName;
  String userProfilePictureUrl;
  bool deleteFlag;
  int subReplyCount;

  List<FBallReplyResDto> fBallReplyResDtos;

  FBallReplyResDto();
  factory FBallReplyResDto.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyResDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyResDtoToJson(this);

  factory FBallReplyResDto.fromFBallReply(FBallReply item){
    FBallReplyResDto fBallReplyResDto = FBallReplyResDto();
    fBallReplyResDto.replyUuid = item.replyUuid;
    fBallReplyResDto.ballUuid = item.ballUuid;
    fBallReplyResDto.uid = item.uid;
    fBallReplyResDto.replyNumber = item.replyNumber;
    fBallReplyResDto.replySort = item.replySort;
    fBallReplyResDto.replyDepth = item.replyDepth;
    fBallReplyResDto.replyText = item.replyText;
    fBallReplyResDto.replyUploadDateTime = item.replyUploadDateTime;
    fBallReplyResDto.replyUpdateDateTime = item.replyUpdateDateTime;
    fBallReplyResDto.userNickName = item.userNickName;
    fBallReplyResDto.userProfilePictureUrl = item.userProfilePictureUrl;
    fBallReplyResDto.deleteFlag = item.deleteFlag;
    fBallReplyResDto.subReplyCount = item.subReplyCount;
    return fBallReplyResDto;
  }
}