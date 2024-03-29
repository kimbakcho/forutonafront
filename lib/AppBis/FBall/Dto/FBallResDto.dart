import 'package:forutonafront/AppBis/FBall/Domain/Entity/FBall.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallState.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallResDto.g.dart';

@JsonSerializable(explicitToJson: true)
class FBallResDto {
  double? latitude;
  double? longitude;
  String? ballUuid;
  String? ballName;
  FBallType? ballType;
  FBallState? ballState;
  String? placeAddress;
  int? ballHits;
  int? ballLikes;
  int? ballDisLikes;
  int? commentCount;
  int? ballPower;
  DateTime? activationTime;
  DateTime? makeTime;
  String? description;
  FUserInfoSimpleResDto? uid;
  int? contributor;
  bool ballDeleteFlag = false;
  bool? isEditContent;
  DateTime? editContentTime;
  int? replyCount;

  FBallResDto();

  static FBallResDto fromJson(Map<String, dynamic> json) => _$FBallResDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallResDtoToJson(this);

  // factory FBallResDto.fromFBall(FBall fBall){
  //   FBallResDto fBallResDto = FBallResDto();
  //   fBallResDto.latitude = fBall.latitude;
  //   fBallResDto.longitude = fBall.longitude;
  //   fBallResDto.ballUuid = fBall.ballUuid;
  //   fBallResDto.ballName = fBall.ballName;
  //   fBallResDto.ballType = fBall.ballType;
  //   fBallResDto.ballState = fBall.ballState;
  //   fBallResDto.placeAddress = fBall.placeAddress;
  //   fBallResDto.ballHits = fBall.ballHits;
  //   fBallResDto.ballLikes = fBall.ballLikes;
  //   fBallResDto.ballDisLikes = fBall.ballDisLikes;
  //   fBallResDto.commentCount = fBall.commentCount;
  //   fBallResDto.ballPower = fBall.ballPower;
  //   fBallResDto.activationTime = fBall.activationTime;
  //   fBallResDto.makeTime = fBall.makeTime;
  //   fBallResDto.description = fBall.description;
  //   fBallResDto.uid = FUserInfoSimpleResDto.fromFUserInfoSimple(fBall.uid);
  //   fBallResDto.contributor = fBall.contributor;
  //   fBallResDto.ballDeleteFlag = fBall.ballDeleteFlag;
  //   return fBallResDto;
  // }

}
