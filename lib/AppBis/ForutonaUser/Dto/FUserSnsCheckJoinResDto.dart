import 'package:json_annotation/json_annotation.dart';

part 'FUserSnsCheckJoinResDto.g.dart';

@JsonSerializable()
class FUserSnsCheckJoinResDto {
  String? snsUid;
  String? pictureUrl;
  String? email;
  String? userSnsName;
  //회원 가입 여부
  bool join=false;
  //기존 유저시 토큰 부여
  String? firebaseCustomToken;


  FUserSnsCheckJoinResDto();


  factory FUserSnsCheckJoinResDto.fromJson(Map<String, dynamic> json) => _$FUserSnsCheckJoinResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserSnsCheckJoinResDtoToJson(this);
}