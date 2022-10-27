import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const notifEnabled='NOTIF_ENABLED';
  PreferencesHelper({required this.sharedPreferences});
  Future<bool> get isNotifEnabled async {
    final prefs = await sharedPreferences;
    return prefs.getBool(notifEnabled)??false;
  }
  void setNotifEnabled(bool value) async{
    final prefs = await sharedPreferences;
    prefs.setBool(notifEnabled, value);
  }
}