import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import './env.dart';

import './Classes/UserInformation.dart';
import './Classes/Functions.dart';
import './Classes/Dictionairy.dart';

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
import 'Screens/AddAddressScreen.dart';
import 'Screens/ConfirmationScreen.dart';
import 'Screens/SearchScreen.dart';
import 'Screens/ChooseLanguageScreen.dart';
import 'Screens/VersionNotSupported.dart';

void main() {
  runApp(
    Phoenix(
      child: MyApp()
    )
  );
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  bool isLoading = true;
  bool isLanguageChosen = true;
  bool versionIsSupported = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*//////////////////////////////////////////////////////////////
    // checking if the version is suppprted before doing anything // 
    *///////////////////////////////////////////////////////////////
    http.get(env.apiUrl + "/api/minimumversion").then((value){
      print(value.body);
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        versionIsSupported = Functions.isVersionSupported(packageInfo.version + "." + packageInfo.buildNumber, value.body);
        print(packageInfo.version + "." + packageInfo.buildNumber);
        print("finished writing");
      });
    });

    /*//////////////////////////////////////////////////////////////
    // getting user information from storage if its session still //
    // valid and making http request to the server to gain access //
    *///////////////////////////////////////////////////////////////
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getString("language") == null){
        setState(() {
          isLanguageChosen = false;
        });
      }
      if(prefs.getString("sessionID") != null){
        http.post(env.apiUrl + "/api/checkUserSession", body: {
          "email": prefs.getString("email"),
          "sessionID": prefs.getString("sessionID"),
        }).then((result){
          var response = json.decode(result.body);
          if(response["error"] != null){
            print(response["error"]);
            prefs.remove("sessionID");
            UserInformation();
            setState(() {
              isLoading = false;
              isLoggedIn = false;
            });
            return;
          }
          UserInformation();  // saving logged in user information
          setState(() {
            isLoggedIn = true;
            isLoading = false;
          });
        })
        .catchError((onError){
          print("Catch error");
          print(onError);
          Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
        });
      }
      else{
        UserInformation();  // saving logged in user information
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
      title: '7anut Web',
      home: !versionIsSupported ? VersionNotSupported() : isLanguageChosen ? isLoading ? LoadingLogo() : isLoggedIn ? HomeScreen() : LoginScreen() : ChooseLanguageScreen(),
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
        "/search": (context) => SearchScreen(),
        "/language": (context) => ChooseLanguageScreen(),
      },
    );
  }
}