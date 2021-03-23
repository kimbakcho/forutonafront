
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Preference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallReply.g.dart';

@JsonSerializable()
class FBallReply {


  String replyUuid;
  String ballUuid;
  String uid;
  int replyNumber;
  int replySort;
  int replyDepth;
  String _replyText;
  DateTime replyUploadDateTime;
  DateTime replyUpdateDateTime;
  String _userNickName;
  String _userProfilePictureUrl;
  bool deleteFlag;
  int subReplyCount;

  String get replyText{
    if(deleteFlag){
      return "삭제됨";
    }else {
      return _replyText;
    }
  }

  get replyUploadDateTimeString {
    if(deleteFlag){
      return "";
    }else {
      return TimeDisplayUtil.getCalcToStrFromNow(replyUploadDateTime);
    }


  }

  set replyText(String value) {
    _replyText = value;
  }


  String get userNickName {
    if(deleteFlag){
      return "";
    }else {
      return _userNickName;
    }
  }

  set userNickName(String value) {
    _userNickName = value;
  }


  String get userProfilePictureUrl {
    if(deleteFlag){
      return null;
    }else {
      return _userProfilePictureUrl;
    }
  }

  set userProfilePictureUrl(String value) {
    _userProfilePictureUrl = value;
  }


  List<FBallReply> fBallSubReplys = [];



  FBallReply();

  factory FBallReply.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyToJson(this);




}