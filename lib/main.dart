import 'package:flutter/material.dart';
import 'package:lino_parents/src/Controller/all_controllers.dart';
import 'package:lino_parents/src/Model/repository.dart';
import 'package:lino_parents/src/View/dashboard/chat_screen_dates.dart';
import 'package:lino_parents/src/View/dashboard/detailed_chat_screen.dart';
import 'package:lino_parents/src/View/onBoarding/login_screen.dart';
import 'package:lino_parents/src/View/dashboard/setting_screen.dart';
import 'package:lino_parents/src/View/onBoarding/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  localDb.value.uid == null;
  await AllController().getDataLocally(); // pehle hi data load
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Baloo2'),
      initialRoute: localDb.value.uid == null
          ? '/'
          : localDb.value.uid == ""
          ? '/login'
          : '/setting',
      routes: {
        '/': (context) => const Splash(),
        '/login': (context) => LoginScreen(),
        '/setting': (context) => SettingScreen(),
        '/chatDates': (context) => ChatScreenDates()
      },
    );
  }
}
