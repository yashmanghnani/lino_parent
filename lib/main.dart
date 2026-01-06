import 'package:flutter/material.dart';
import 'package:lino_parents/src/View/onBoarding/login_screen.dart';
import 'package:lino_parents/src/View/onBoarding/setting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Baloo2'),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/setting': (context) => SettingScreen(),
      },
    );
  }
}
