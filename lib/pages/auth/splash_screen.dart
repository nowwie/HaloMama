import 'package:flutter/material.dart';
import 'dart:async';

import 'package:halomama/components/constan.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Mulai fade in setelah 300ms
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Pindah ke onboarding setelah 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MyColors.normalActive,
              MyColors.normal,
            ],
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 1), // durasi animasi fade
            curve: Curves.easeInOut,
            child: Image.asset(
              'assets/images/logo_splash.png',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
