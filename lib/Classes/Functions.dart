import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/LoginScreen.dart';

import '../Classes/Basket.dart';

abstract class Functions extends StatelessWidget {
  static void logout(BuildContext context, String theMessge, Color theColor){
    Basket.clearBasket();
    SharedPreferences.getInstance().then((prefs){
      prefs.remove("sessionID").then((value){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => theMessge != null ? LoginScreen(message: theMessge, theColor: theColor,) : LoginScreen()), (route) => false);
      });
    });
  }
}