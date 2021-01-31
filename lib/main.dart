import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './env.dart';
import './Classes/UserInformation.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/RegisterScreen.dart';
import 'Screens/ForgotPasswordScreen.dart';
import 'Screens/CategoryScreen.dart';
import 'Screens/OrdersScreen.dart';
import 'Screens/ProfileScreen.dart';
import 'Screens/EditProfileScreen.dart';
import 'Screens/BasketScreen.dart';
import 'Screens/LoadingLogoScreen.dart';
import 'Screens/CheckoutScreen.dart';
import 'Screens/AdressesScreen.dart';
import 'Screens/GetLocationScreen.dart';
import 'Screens/AddAddressScreen.dart';
import 'Screens/ConfirmationScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*//////////////////////////////////////////////////////////////
    // getting user information from storage if its session still //
    // valid and making http request to the server to gain access //
    *///////////////////////////////////////////////////////////////
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getString("sessionID") != null){
        http.post(env.apiUrl + "/api/checkUserSession", body: {
          "email": prefs.getString("email"),
          "sessionID": prefs.getString("sessionID"),
        }).then((result){
          var response = json.decode(result.body);
          if(response["error"] != null){
            print(response["error"]);
            prefs.remove("sessionID");
            setState(() {
              isLoading = false;
              isLoggedIn = false;
            });
            return;
          }
          // saving logged in user information
          UserInformation();
          setState(() {
            isLoggedIn = true;
            isLoading = false;
          });
        });
      }
      else{
        setState(() {
          isLoading = false;
          isLoggedIn = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // to remove the debug banner
      title: 'Flutter Demo',
      home: isLoading ? LoadingLogo() : isLoggedIn ? HomeScreen() : LoginScreen(),
      // home: ProfileScreen(),
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
        "/checkout": (context) => CheckoutScreen(),
        "/adresses": (context) => AdressesScreen(),
        "/addaddress": (context) => AddAddressScreen(),
        "/confirmation": (context) => ConfirmationScreen(),
      },
    );
  }
}