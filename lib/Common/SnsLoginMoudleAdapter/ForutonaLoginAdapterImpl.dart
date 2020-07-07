import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';

import 'SnsLoginModuleAdapter.dart';

class ForutonaLoginAdapterImpl implements SnsLoginModuleAdapter {
  @override
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo() async {
    return null;
  }

  @override
  SnsSupportService snsSupportService = SnsSupportService.Forutona;

  @override
  Future<void> logout() async{
    return ;
  }
}
