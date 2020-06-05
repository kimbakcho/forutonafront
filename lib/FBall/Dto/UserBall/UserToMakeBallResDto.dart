import 'package:forutonafront/FBall/Data/Entity/UserToMakeBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallState.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
part 'UserToMakeBallResDto.g.dart';

@JsonSerializable()
class UserToMakeBallResDto extends FBallResDto {
  factory UserToMakeBallResDto.fromJson(Map<String, dynamic> json) => _$UserToMakeBallResDtoFromJson(json);

  factory UserToMakeBallResDto.fromUserToMakerBall(UserToMakeBall userToMakerBall){
    UserToMakeBallResDto userToMakerBallResDto = UserToMakeBallResDto();
    userToMakerBallResDto.latitude = userToMakerBall.latitude;
    userToMakerBallResDto.longitude = userToMakerBall.longitude;
    userToMakerBallResDto.ballUuid = userToMakerBall.ballUuid;
    userToMakerBallResDto.ballName = userToMakerBall.ballName;
    userToMakerBallResDto.ballType = userToMakerBall.ballType;
    userToMakerBallResDto.ballState = userToMakerBall.ballState;
    userToMakerBallResDto.placeAddress = userToMakerBall.placeAddress;
    userToMakerBallResDto.ballHits = userToMakerBall.ballHits;
    userToMakerBallResDto.ballLikes = userToMakerBall.ballLikes;
    userToMakerBallResDto.ballDisLikes = userToMakerBall.ballDisLikes;
    userToMakerBallResDto.commentCount = userToMakerBall.commentCount;
    userToMakerBallResDto.ballPower = userToMakerBall.ballPower;
    userToMakerBallResDto.activationTime = userToMakerBall.activationTime;
    userToMakerBallResDto.makeTime = userToMakerBall.makeTime;
    userToMakerBallResDto.description = userToMakerBall.description;
    userToMakerBallResDto.nickName = userToMakerBall.nickName;
    userToMakerBallResDto.profilePictureUrl = userToMakerBall.profilePictureUrl;
    userToMakerBallResDto.uid = userToMakerBall.uid;
    userToMakerBallResDto.userLevel = userToMakerBall.userLevel;
    userToMakerBallResDto.contributor = userToMakerBall.contributor;
    userToMakerBallResDto.ballDeleteFlag = userToMakerBall.ballDeleteFlag;
    return userToMakerBallResDto;
  }

  Map<String, dynamic> toJson() => _$UserToMakeBallResDtoToJson(this);
  UserToMakeBallResDto() ;
}