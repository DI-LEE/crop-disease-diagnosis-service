import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Result_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //로딩 화면 디자인
    return AnimatedSplashScreen(
        splash: Lottie.asset('assets/animation/3.json'),
        backgroundColor: Color(0xffE8F4EB),
        nextScreen: ResultPage(),
      splashIconSize: 150,
      duration: 45000,
    );
  }
}
