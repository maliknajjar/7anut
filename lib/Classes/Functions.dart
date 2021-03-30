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
  
  static bool isVersionSupported(String currentVersion, String minimumVersion){
    List cvarr = currentVersion.split(".");
    List mvarr = minimumVersion.split(".");
    for (int i = 0; i < cvarr.length; i++){
      if(int.parse(cvarr[i]) < int.parse(mvarr[i])){
        return false;
      }else if (int.parse(cvarr[i]) == int.parse(mvarr[i])) {
        if (i == cvarr.length - 1) return true;
      }else{
        return true;
      }
    }
  }
}