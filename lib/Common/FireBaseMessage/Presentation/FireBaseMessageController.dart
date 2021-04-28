import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';

import 'package:forutonafront/Common/FireBaseMessage/UseCase/FCMMessageUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FireBaseMessageController {
  final FireBaseMessageAdapter fireBaseMessageAdapter;

  FireBaseMessageController(
      {required this.fireBaseMessageAdapter});


  controllerStartService(){
    this.fireBaseMessageAdapter.configure();
  }

}
