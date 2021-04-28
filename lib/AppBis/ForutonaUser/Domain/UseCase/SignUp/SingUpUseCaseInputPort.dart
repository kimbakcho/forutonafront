
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';

abstract class SingUpUseCaseInputPort {
  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(SnsSupportService? snsService, String? accessToken);
  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto fUserInfoJoinReq,List<int>? profileImage,List<int>? backgroundImage);
  trySignSns(SnsSupportService snsSupportService,BuildContext context);
}