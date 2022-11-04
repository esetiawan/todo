import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/utils/backgroundservice.dart';
import 'package:untitled/utils/datetimehelper.dart';

class SchedulingProvider extends ChangeNotifier{
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;
  Future<bool> scheduledTodo(bool value) async {
    _isScheduled=false;
    if (_isScheduled) {
      print('Scheduling todo activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup:true
      );
    }
    else {
      print('Scheduling Todo Cancelled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}