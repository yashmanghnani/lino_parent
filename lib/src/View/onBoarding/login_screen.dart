import 'package:flutter/material.dart';
import 'package:lino_parents/src/View/widgets/login_screen_widgets';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: .end,
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
            child: Center(
              child: Padding(
                padding: .symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.2,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    LoginScreenWidgets(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
