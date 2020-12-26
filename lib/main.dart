import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class MyApp extends StatefulWidget {
  bool isLoggedIn = false;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs){
      setState(() {
        // prefs.remove("email");
        if(prefs.getString("email") != null) widget.isLoggedIn = true;
        else widget.isLoggedIn = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // to remove the debug banner
      title: 'Flutter Demo',
      home: widget.isLoggedIn ? HomeScreen() : LoginScreen(),
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