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
        return ListView(
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
        );
      }
      );

  }
}