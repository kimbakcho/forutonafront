import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';

import 'Domain/CommentChannel/CommentChannelUseCase.dart';
import 'Domain/RadarBasicChannel/RadarBasicChannelUseCae.dart';

@injectable
abstract class NotificationChannelBaseInputPort {
  reqNotification(Map<String, dynamic> message);
  @factoryMethod
  static NotificationChannelBaseInputPort serviceChannelUseCaseName(@factoryParam String name){
    if(name == "RadarBasicChannelUseCae"){
      return sl.get<NotificationChannelBaseInputPort>(instanceName: "RadarBasicChannelUseCae");
    }else if(name == "CommentChannelUseCase"){
      return sl.get<NotificationChannelBaseInputPort>(instanceName: "CommentChannelUseCase");
    }else {
      return null;
    }
  }
}
