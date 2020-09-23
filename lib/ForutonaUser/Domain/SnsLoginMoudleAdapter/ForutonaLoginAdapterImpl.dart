import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:injectable/injectable.dart';

import 'SnsLoginModuleAdapter.dart';

@named
@LazySingleton(as: SnsLoginModuleAdapter)
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
