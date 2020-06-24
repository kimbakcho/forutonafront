import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';

import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';


class FireBaseMessageController {
  FireBaseMessageAdapter fireBaseMessageAdapter;
  BaseMessageUseCaseInputPort launchMessageUseCase;
  BaseMessageUseCaseInputPort baseMessageUseCase;
  BaseMessageUseCaseInputPort resumeMessageUseCase;

  FireBaseMessageController(
      {@required this.fireBaseMessageAdapter,
      @required this.launchMessageUseCase,
      @required this.baseMessageUseCase,
      @required this.resumeMessageUseCase})
      : assert(fireBaseMessageAdapter != null),
        assert(launchMessageUseCase != null),
        assert(baseMessageUseCase != null),
        assert(resumeMessageUseCase != null);

  controllerStartService(){
    fireBaseMessageAdapter.configure(
        onLaunch: launchMessageUseCase.message,
        onMessage: baseMessageUseCase.message,
        onResume: resumeMessageUseCase.message);


  }
}
