import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/common/navigation.dart';
import 'package:untitled/provider/dbprovider.dart';
import 'package:untitled/provider/preferencesprovider.dart';
import 'package:untitled/provider/schedulingprovider.dart';
import 'package:untitled/ui/settingpage.dart';
import 'package:untitled/ui/todoadd_updatepage.dart';
import 'package:untitled/ui/todolistpage.dart';
import 'package:untitled/utils/backgroundservice.dart';
import 'package:untitled/utils/notificationhelper.dart';
import 'data/model/todo.dart';
import 'data/preferences/preferences_helper.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationHelper _notificationHelper=NotificationHelper();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context)=>DbProvider()),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (context)=>PreferencesProvider(preferencesHelper:
              PreferencesHelper(sharedPreferences: SharedPreferences.getInstance()))),
        ChangeNotifierProvider(
          create: (context)=>SchedulingProvider()),
    ],
      child: MaterialApp(
        title: 'To Do App',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: Center(
                  child:const ToDoListPage()
                ),
            bottomNavigationBar:Builder(builder:(context){
              return BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home'),
                    BottomNavigationBarItem(icon: Icon(Icons.done),label:'Done'),
                    BottomNavigationBarItem(icon: Icon(Icons.settings),label:'Settings'),
                  ],
                  currentIndex: 0,
                  onTap: (index) async {
                    switch(index) {
                      case 0:
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return ToDoListPage();
                        }));
                        break;
                      case 1:
                        //coba notif yang standar jalan
                        final NotificationHelper notificationHelper=NotificationHelper();
                        await notificationHelper.showNotification(
                          flutterLocalNotificationsPlugin,
                          Todo( id: 7,
                              title:"Tugas Nomer 7",
                              detail:"Ini Tugas belajar Flutter")
                        );
                        break;
                      case 2:
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return SettingPage();
                        }));
                        break;
                    }
                  }
              );
            })
          ),
        ),
      );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(ToAddUpdatePage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}


