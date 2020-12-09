import 'package:flutter/material.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/RegisterScreen.dart';
import 'Screens/ForgotPasswordScreen.dart';
import 'Screens/CategoryScreen.dart';
import 'Screens/OrdersScreen.dart';
import 'Screens/ProfileScreen.dart';
import 'Screens/EditProfileScreen.dart';
import 'Screens/BasketScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var selectedItems = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // to remove the debug banner
      title: 'Flutter Demo',
      initialRoute: "/category",
      routes: {
        "/home": (context) => HomeScreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/forgotpassword": (context) => ForgotPasswordScreen(),
        "/category": (context) => CategoryScreen(),
        "/orders": (context) => OrdersScreen(),
        "/profile": (context) => ProfileScreen(),
        "/editprofile": (context) => EditProfileScreen(),
        "/basket": (context) => BasketScreen(),
      },
    );
  }
}