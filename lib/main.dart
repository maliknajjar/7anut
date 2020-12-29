import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  bool isLoading = true;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((prefs){
      if(prefs.getString("sessionID") != null){
        http.post("http://10.0.2.2:8000/api/checkUserSession", body: {
          "email": prefs.getString("email"),
          "sessionID": prefs.getString("sessionID"),
        }).then((result){
          var response = json.decode(result.body);
          print(response);
          if(response["error"] != null){
            print(response["error"]);
            prefs.remove("sessionID");
            setState(() {
              widget.isLoading = false;
              widget.isLoggedIn = false;
            });
            return;
          }
          print("success");
          setState(() {
            widget.isLoggedIn = true;
            widget.isLoading = false;
          });
        });
      }
      else{
        setState(() {
          widget.isLoading = false;
          widget.isLoggedIn = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // to remove the debug banner
      title: 'Flutter Demo',
      home: widget.isLoading ? Scaffold(body: Center(child: Text("loading"),),) : widget.isLoggedIn ? HomeScreen() : LoginScreen(),
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