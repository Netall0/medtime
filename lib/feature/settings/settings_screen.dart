import 'package:flutter/material.dart';
import 'package:medtime/core/routing.dart';
import 'package:uikit/uikit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AdaptiveButton.icon(
          onPressed: () {
            context.pop();
          },
          icon: Icons.safety_check,
          label: Text('sas'),
        ),
      ),
      backgroundColor: Colors.amberAccent,
    );
  }
}
