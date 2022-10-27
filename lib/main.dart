import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/provider/dbprovider.dart';
import 'package:untitled/provider/preferencesprovider.dart';
import 'package:untitled/ui/settingpage.dart';
import 'package:untitled/ui/todolistpage.dart';

import 'data/preferences/preferences_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DbProvider()),
        ChangeNotifierProvider<PreferencesProvider>(
            create: (context) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                    sharedPreferences: SharedPreferences.getInstance()))),
      ],
      child: MaterialApp(
        title: 'To Do App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            body: Center(child: const ToDoListPage()),
            bottomNavigationBar: Builder(builder: (context) {
              return BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.done), label: 'Done'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings'),
                  ],
                  currentIndex: 0,
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ToDoListPage();
                        }));
                        break;
                      case 1:
                        break;
                      case 2:
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SettingPage();
                        }));
                        break;
                    }
                  });
            })),
      ),
    );
  }
}
