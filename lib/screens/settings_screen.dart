import 'package:flutter/material.dart';
import 'package:kudinkaa/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);


  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return OnBoardingPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('ShowHome', false);
          _onIntroEnd(context);
        }, icon: Icon(Icons.logout_outlined),),
      ),
    );
  }
}
