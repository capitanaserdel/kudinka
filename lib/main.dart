import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kudinkaa/providers/auth.dart';
import 'package:kudinkaa/screens/login_screen.dart';
import 'package:kudinkaa/screens/onboarding_screen.dart';
import 'package:kudinkaa/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('ShowHome') ?? false;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(App(ShowHome: showHome));
}


Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(milliseconds: 150));
}

class App extends StatelessWidget {
  final bool ShowHome;

  App({
    Key? key,
    required this.ShowHome,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => Auth(),)
    ],child:  MaterialApp(
      title: 'KudiKan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle()),
        fontFamily: 'Roboto',
        buttonColor: Colors.green.shade500,
        primarySwatch: Colors.green,
      ),
      home: ShowHome ? SettingsScreen() : OnBoardingPage(),
      routes: {

      },
    ),);
     
  }
}


