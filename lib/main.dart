import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halomama/main_screen.dart';
import 'package:halomama/pages/user/activity_page.dart';
import 'package:halomama/pages/user/profile_page.dart';
import 'firebase_options.dart';
import 'package:halomama/pages/auth/forgot_password_reset.dart';
import 'package:halomama/pages/auth/forgot_password_verification.dart';
import 'package:halomama/pages/auth/login_page.dart';
import 'package:halomama/pages/auth/onBoarding1.dart';
import 'package:halomama/pages/auth/splash_screen.dart';
import 'package:halomama/pages/auth/onBoarding2.dart';
import 'package:halomama/pages/auth/onBoarding3.dart';
import 'package:halomama/pages/auth/register_user.dart';
import 'package:halomama/pages/user/dashboard.dart';
import 'package:halomama/pages/user/maya_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',

      onGenerateRoute: (settings) {
    switch (settings.name) {
      case '/forgot_password_verification':
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordVerification(email: email),
        );
      case '/forgot_password_reset':
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordReset(email: email),
        );
      // ...route lain...
      default:
        return null;
    }},
      routes: {
        '/splash': (context)=> const SplashScreen(),
        '/onboarding1': (context)=> const OnboardingScreen1(),
        '/onboarding2': (context)=> const OnboardingScreen2(),
        '/onboarding3': (context)=> const OnboardingScreen3(),
        '/register': (context)=> const RegisterPage(),
        '/login': (context)=> const LoginPage(),
        '/home': (context) => MainScreen(),
        '/maya': (context) => MayaPage(),
        '/profile': (context) => ProfileScreen(),
        '/activity': (context) => ActivityPage(),
      },
      
      
    );
  }

}