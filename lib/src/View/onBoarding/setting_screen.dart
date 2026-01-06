import 'package:flutter/material.dart';
import 'package:lino_parents/src/View/widgets/setting_screen_widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.01),
          child: SizedBox(
            width: size.width * 0.2,
            height: size.height * 0.12,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                height: size.height * .25,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffFFFFFF), Color(0xffAF52DE)],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height,
            child: Padding(
              padding: .symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: SingleChildScrollView(child: SettingScreenWidgets()),
            ),
          ),
        ],
      ),
    );
  }
}
