import 'package:forutonafront/FBall/Data/Entity/UserToPlayBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallState.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'package:json_annotation/json_annotation.dart';


part 'UserToPlayBallResDto.g.dart';



@JsonSerializable()
class UserToPlayBallResDto extends FBallResDto{
  DateTime joinTime;

  UserToPlayBallResDto();

  factory UserToPlayBallResDto.fromUserToPlayBall(UserToPlayBall userToPlayBall){
    UserToPlayBallResDto userToPlayBallResDto = UserToPlayBallResDto();
    userToPlayBallResDto.latitude = userToPlayBall.latitude;
    userToPlayBallResDto.longitude = userToPlayBall.longitude;
    userToPlayBallResDto.ballUuid = userToPlayBall.ballUuid;
    userToPlayBallResDto.ballName = userToPlayBall.ballName;
    userToPlayBallResDto.ballType = userToPlayBall.ballType;
    userToPlayBallResDto.ballState = userToPlayBall.ballState;
    userToPlayBallResDto.placeAddress = userToPlayBall.placeAddress;
    userToPlayBallResDto.ballHits = userToPlayBall.ballHits;
    userToPlayBallResDto.ballLikes = userToPlayBall.ballLikes;
    userToPlayBallResDto.ballDisLikes = userToPlayBall.ballDisLikes;
    userToPlayBallResDto.commentCount = userToPlayBall.commentCount;
    userToPlayBallResDto.ballPower = userToPlayBall.ballPower;
    userToPlayBallResDto.activationTime = userToPlayBall.activationTime;
    userToPlayBallResDto.makeTime = userToPlayBall.makeTime;
    userToPlayBallResDto.description = userToPlayBall.description;
    userToPlayBallResDto.nickName = userToPlayBall.nickName;
    userToPlayBallResDto.profilePictureUrl = userToPlayBall.profilePictureUrl;
    userToPlayBallResDto.uid = userToPlayBall.uid;
    userToPlayBallResDto.userLevel = userToPlayBall.userLevel;
    userToPlayBallResDto.contributor = userToPlayBall.contributor;
    userToPlayBallResDto.ballDeleteFlag = userToPlayBall.ballDeleteFlag;
    userToPlayBallResDto.joinTime = userToPlayBall.joinTime;
    return userToPlayBallResDto;
  }


  factory UserToPlayBallResDto.fromJson(Map<String, dynamic> json) => _$UserToPlayBallResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToPlayBallResDtoToJson(this);

}