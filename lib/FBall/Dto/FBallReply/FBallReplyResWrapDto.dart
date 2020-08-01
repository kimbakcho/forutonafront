import 'package:forutonafront/FBall/Domain/Value/FBallReplyResWrap.dart';
import 'package:json_annotation/json_annotation.dart';

import 'FBallReplyResDto.dart';

part 'FBallReplyResWrapDto.g.dart';

@JsonSerializable()
class FBallReplyResWrapDto {
  int count;
  int offset;
  int pageSize;
  int replyTotalCount;
  bool onlySubReply;
  List<FBallReplyResDto> contents = [];

  FBallReplyResWrapDto();

  factory FBallReplyResWrapDto.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyResWrapDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyResWrapDtoToJson(this);

  factory FBallReplyResWrapDto.fromFBallReplyResWrap(FBallReplyResWrap item) {
    FBallReplyResWrapDto fBallReplyResWrapDto = FBallReplyResWrapDto();
    fBallReplyResWrapDto.replyTotalCount = item.replyTotalCount;
    fBallReplyResWrapDto.offset = item.offset;
    fBallReplyResWrapDto.pageSize = item.pageSize;
    fBallReplyResWrapDto.count = item.count;
    fBallReplyResWrapDto.onlySubReply = item.onlySubReply;
    fBallReplyResWrapDto.contents =
        item.contents.map((x) => FBallReplyResDto.fromFBallReply(x)).toList();

    return fBallReplyResWrapDto;
  }
}
