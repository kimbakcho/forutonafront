import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:injectable/injectable.dart';

import 'SnsLoginModuleAdapter.dart';

class ForutonaLoginAdapterImpl implements SnsLoginModuleAdapter {

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  final String userEmailId;

  final String password;

  ForutonaLoginAdapterImpl(this._fireBaseAuthAdapterForUseCase, this.userEmailId, this.password);

  @override
  Future<SnsLoginModuleResDto?> getSnsModuleUserInfo() async {
    return null;
  }

  @override
  SnsSupportService? snsSupportService = SnsSupportService.Forutona;

  @override
  Future<void> logout() async{
    return ;
  }

  @override
  Future<void> login(FUserSnsCheckJoinResDto? fUserSnsCheckJoinResDto) async {
      await _fireBaseAuthAdapterForUseCase.signInWithEmailAndPassword(userEmailId, password);
  }
}
