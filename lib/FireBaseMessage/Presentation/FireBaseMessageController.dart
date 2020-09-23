import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';

import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class FireBaseMessageController {
  FireBaseMessageAdapter _fireBaseMessageAdapter;
  BaseMessageUseCaseInputPort _launchMessageUseCase;
  BaseMessageUseCaseInputPort _baseMessageUseCase;
  BaseMessageUseCaseInputPort _resumeMessageUseCase;

  FireBaseMessageController(
      {@required FireBaseMessageAdapter fireBaseMessageAdapter,
      @required BaseMessageUseCaseInputPort launchMessageUseCase,
      @required BaseMessageUseCaseInputPort baseMessageUseCase,
      @required BaseMessageUseCaseInputPort resumeMessageUseCase})
      : _fireBaseMessageAdapter = fireBaseMessageAdapter,
        _launchMessageUseCase = launchMessageUseCase,
        _baseMessageUseCase = baseMessageUseCase,
        _resumeMessageUseCase = resumeMessageUseCase;

  controllerStartService(){
    _fireBaseMessageAdapter.configure(
        onLaunch: _launchMessageUseCase.message,
        onMessage: _baseMessageUseCase.message,
        onResume: _resumeMessageUseCase.message);
  }
}
