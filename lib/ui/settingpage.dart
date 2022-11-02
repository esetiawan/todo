import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/dbprovider.dart';
import 'package:untitled/provider/preferencesprovider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context,provider,child) {
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
                      trailing: Switch.adaptive(value: provider.isNotifEnabled,
                          onChanged: (value) {
                            provider.enableNotif(value);
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