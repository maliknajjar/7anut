import 'package:flutter/material.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/RegisterScreen.dart';
import 'Screens/ForgotPasswordScreen.dart';
import 'Screens/CategoryScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/category",
      routes: {
        "/home": (context) => HomeScreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/forgotpassword": (context) => ForgotPasswordScreen(),
        "/category": (context) => CategoryScreen(),
      },
    );
  }
}