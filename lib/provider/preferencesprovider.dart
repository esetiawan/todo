import 'package:flutter/cupertino.dart';
import 'package:untitled/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier{
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}){
    _getNotifEnabled();
  }

  bool _isNotifEnabled = false;

  bool get isNotifEnabled => _isNotifEnabled;

  set isNotifEnabled(bool value) {
    _isNotifEnabled = value;
  }
  void _getNotifEnabled() async{
    _isNotifEnabled = await preferencesHelper.isNotifEnabled;
    notifyListeners();
  }
  void enableNotif(bool value) {
    preferencesHelper.setNotifEnabled(value);
    _getNotifEnabled();
  }
}