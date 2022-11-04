import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/dbprovider.dart';
import 'package:untitled/provider/preferencesprovider.dart';
import 'package:untitled/provider/schedulingprovider.dart';

class SettingPage extends StatelessWidget {
  static const routeName='/setting';
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferencesProvider,SchedulingProvider>(
      builder: (context,preferencesProvider,schedulingProvider,child) {
        return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("Setting"),
          ),
          body: ListView(
              children: [
                Material(
                  child: ListTile(
                      title: const Text('Enable Notifications'),
                      trailing: Switch.adaptive(value: preferencesProvider.isNotifEnabled,
                          onChanged: (value) {
                            preferencesProvider.enableNotif(value);
                            schedulingProvider.scheduledTodo(value);
                          })
                  ),
                ),
              ]
          ),
        );
      }
      );

  }
}