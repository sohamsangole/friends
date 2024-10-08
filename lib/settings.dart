import 'package:flutter/material.dart';
import 'package:friends/components/mytext.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: MyText(
        data: "Settings",
        fontSize: 30,
      ),
    );
  }
}
