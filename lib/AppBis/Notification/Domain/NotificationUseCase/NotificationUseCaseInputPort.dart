import 'package:flutter/material.dart';

abstract class NotificationUseCaseInputPort {
  Future<void> resNotification(Map<String, dynamic> message);
  Future<void> selectAction(BuildContext context,String payload);
}