import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageAdapter.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenReFreshUseCase/FireBaseTokenReFreshUseCaseInputPort.dart';

class FireBaseMessageController {
  FireBaseMessageAdapter fireBaseMessageAdapter;
  BaseMessageUseCaseInputPort launchMessageUseCase;
  BaseMessageUseCaseInputPort baseMessageUseCase;
  BaseMessageUseCaseInputPort resumeMessageUseCase;
  FireBaseTokenReFreshUseCaseInputPort fireBaseTokenReFreshUseCaseInputPort;

  FireBaseMessageController(
      {@required this.fireBaseMessageAdapter,
      @required this.launchMessageUseCase,
      @required this.baseMessageUseCase,
      @required this.resumeMessageUseCase,
      @required this.fireBaseTokenReFreshUseCaseInputPort})
      : assert(fireBaseMessageAdapter != null),
        assert(launchMessageUseCase != null),
        assert(baseMessageUseCase != null),
        assert(resumeMessageUseCase != null);

  controllerStartService(){

    fireBaseMessageAdapter.configure(
        onLaunch: launchMessageUseCase.message,
        onMessage: baseMessageUseCase.message,
        onResume: resumeMessageUseCase.message);

    fireBaseMessageAdapter
        .setRefreshTokenUseCase(fireBaseTokenReFreshUseCaseInputPort);


  }
}
