import 'package:flutter/material.dart';

class LocalizationsProvider extends ChangeNotifier{
  Locale _locale = const Locale("id");
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }


}