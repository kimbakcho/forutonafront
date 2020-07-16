// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/Notification/MessageChanel/Domain/MessageChanelUseCaseInputPort.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerFactory<FlutterLocalNotificationsPluginAdapter>(
        () => FlutterLocalNotificationsPluginAdapterImpl());
    g.registerFactory<MessageChanelUseCaseInputPort>(() => MessageChanelUseCase(
        flutterLocalNotificationsPluginAdapter:
            g<FlutterLocalNotificationsPluginAdapter>()));
  }
}
