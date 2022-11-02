import 'dart:isolate';
import 'dart:ui';

import 'package:untitled/notificationhelper.dart';

final ReceivePort port = ReceivePort();
class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;
  BackgroundService._internal() {
    _instance=this;
  }
  factory BackgroundService() => _instance ?? BackgroundService._internal();
  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }
  static Future<void> callback() async {
    print('Alarm aktif');
    final NotificationHelper notificationHelper = NotificationHelper();

  }
}