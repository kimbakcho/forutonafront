import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart';

import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/LaunchMessageUseCase/LaunchMessageUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FireBaseMessageController {
  final FireBaseMessageAdapter fireBaseMessageAdapter;
  final BaseMessageUseCaseInputPort launchMessageUseCase;
  final BaseMessageUseCaseInputPort baseMessageUseCase;
  final BaseMessageUseCaseInputPort resumeMessageUseCase;

  FireBaseMessageController(
      {@required this.fireBaseMessageAdapter,
      @required @Named.from(LaunchMessageUseCase) this.launchMessageUseCase,
      @required @Named.from(BaseMessageUseCase) this.baseMessageUseCase,
      @required @Named.from(ResumeMessageUseCase) this.resumeMessageUseCase});


  controllerStartService(){
    fireBaseMessageAdapter.configure(
        onLaunch: launchMessageUseCase.message,
        onMessage: baseMessageUseCase.message,
        onResume: resumeMessageUseCase.message);
  }

}
