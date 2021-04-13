
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationChannel {
  NotificationDetails getChannel();
}