
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoJoin.g.dart';

@JsonSerializable()

class FUserInfoJoin {
  String customToken;
  bool joinComplete;

  FUserInfoJoin();


  factory FUserInfoJoin.fromJson(Map<String, dynamic> json) => _$FUserInfoJoinFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoJoinToJson(this);

}