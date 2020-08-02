
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallState.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfoSimple.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBall.g.dart';

@JsonSerializable(explicitToJson: true)
class FBall {
  double latitude;
  double longitude;
  String ballUuid;
  String ballName;
  FBallType ballType;
  FBallState ballState;
  String placeAddress;
  int ballHits;
  int ballLikes;
  int ballDisLikes;
  int commentCount;
  int ballPower;
  DateTime activationTime;
  DateTime makeTime;
  String description;
  String nickName;
  String profilePictureUrl;
  FUserInfoSimple uid;
  double userLevel;
  int contributor;
  bool ballDeleteFlag;

  @JsonKey(ignore: true)
  FBallRepository _fBallRepository;

  FBall();

  factory FBall.fromJson(Map<String, dynamic> json) =>
      _$FBallFromJson(json);

  Map<String, dynamic> toJson() => _$FBallToJson(this);

  Future<void> ballHit() async {
     ballHits = await _fBallRepository.ballHit(ballUuid);
  }

  Future<void> ballUpdate(FBallUpdateReqDto reqDto) async {
    var fBallResDto = await _fBallRepository.updateBall(reqDto);
    longitude = fBallResDto.longitude;
    latitude = fBallResDto.latitude;
    ballName = fBallResDto.ballName;
    ballType = fBallResDto.ballType;
    placeAddress = fBallResDto.placeAddress;
    description = fBallResDto.description;
  }

  Future<void> delete() async{
    await _fBallRepository.deleteBall(ballUuid);
    ballDeleteFlag =true;
    description = "{}";
  }

  Future<void> like(int point){

  }


}
