import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';

import 'FireBaseMessageTokenUpdateUseCaseInputPort.dart';

class FireBaseMessageTokenUpdateUseCase
    implements FireBaseMessageTokenUpdateUseCaseInputPort {
  final FUserRepository _fUserRepository;

  FireBaseMessageTokenUpdateUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  Future<int> updateFireBaseMessageToken(String uid, String token) {
    return _fUserRepository.updateFireBaseMessageToken(uid, token);
  }
}
