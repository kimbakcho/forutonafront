import 'package:forutonafront/Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCaeInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Dto/NotificationChannelDto.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class RadarBasicChannelUseCae implements NotificationChannelBaseInputPort {
  String groupChannelId = 'co.kr.forutonaforutona.radarbasic';
  String groupChannelName = 'radarbasic';
  String groupChannelDescription = '당신주변에서 새로운Ball이발견되었습니다';
  NotificationChannelDto _notificationChannelDto;

  @override
  reqNotification(Map<String, dynamic> message) async {
    if (hasServiceNotification(message)) {
      _radarBasicServiceAction(message);
    }
  }

  RadarBasicChannelUseCae() {
    _notificationChannelDto = NotificationChannelDto(
        channelId: groupChannelId,
        channelName: groupChannelName,
        channelDescription: groupChannelDescription);
  }

  bool hasServiceNotification(Map<String, dynamic> message) =>
      message["data"].containsKey("serviceKey");

  void _radarBasicServiceAction(Map<String, dynamic> message) {
    RadarBasicChannelUseCaeInputPort
    radarBasicChannelUseCaeInputPort = sl.get<RadarBasicChannelUseCaeInputPort>(
        instanceName: "RadarBasicChannelUseCaeInputPortFactory",
        param1: message["data"]["serviceKey"]);

    radarBasicChannelUseCaeInputPort.reqNotification(message,_notificationChannelDto);
  }
}
