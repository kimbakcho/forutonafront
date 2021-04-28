import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallValuationResDto.dart';

import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallReplyResDto.g.dart';

@JsonSerializable(explicitToJson: true)
class FBallReplyResDto {
  String? replyUuid;
  FBallResDto? ballUuid;
  FUserInfoSimpleResDto? uid;
  int? replyNumber;
  int? replySort;
  int? replyDepth;
  String? replyText;
  DateTime? replyUploadDateTime;
  DateTime? replyUpdateDateTime;
  String? userNickName;
  String? userProfilePictureUrl;
  bool? deleteFlag;
  FBallValuationResDto? fballValuationResDto;
  int? childCount;
  List<FBallReplyResDto>? childFBallReplyResDto = [];

  FBallReplyResDto();
  static FBallReplyResDto fromJson(Map<String, dynamic> json) =>
      _$FBallReplyResDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyResDtoToJson(this);

}