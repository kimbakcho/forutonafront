
import 'package:flutter/cupertino.dart';

import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';


import 'FireBaseMessageTokenUpdateUseCaseInputPort.dart';


class FireBaseMessageTokenUpdateUseCase implements FireBaseMessageTokenUpdateUseCaseInputPort{

  final FUserRepository fUserRepository;

  FireBaseMessageTokenUpdateUseCase({@required this.fUserRepository}):assert(fUserRepository!=null);

  @override
  Future<int> updateFireBaseMessageToken(String uid,String token) {
    return fUserRepository.updateFireBaseMessageToken(uid,token);
  }

}