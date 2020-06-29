import 'package:json_annotation/json_annotation.dart';

part 'FUserSnsCheckJoin.g.dart';

@JsonSerializable()
class FUserSnsCheckJoin {
  String snsUid;
  String pictureUrl;
  String email;
  String userSnsName;
  //회원 가입 여부
  bool join;
  //기존 유저시 토큰 부여
  String firebaseCustomToken;

  FUserSnsCheckJoin();
  factory FUserSnsCheckJoin.fromJson(Map<String, dynamic> json) => _$FUserSnsCheckJoinFromJson(json);
  Map<String, dynamic> toJson() => _$FUserSnsCheckJoinToJson(this);
}