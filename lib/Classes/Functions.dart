import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/LoginScreen.dart';

import './Basket.dart';
import './Dictionairy.dart';
import './UserInformation.dart';

abstract class Functions extends StatelessWidget {
  static void logout(BuildContext context, String theMessge, Color theColor){
    Basket.clearBasket();
    Basket.simpleArray.clear();
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

  static void showTheDialogue(context, String text){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
      return StatefulBuilder(
        builder: (context, setState) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              backgroundColor: Colors.yellow[50],
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 300
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40, top: 20),
                      child: Text(Dictionairy.words[text][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.025),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(Dictionairy.words["Ok"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ),
          );
        }
      );
    }).then((value){
      
    });
  }
}