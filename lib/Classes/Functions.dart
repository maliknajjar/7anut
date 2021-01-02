import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Functions extends StatelessWidget {
  static void logout(BuildContext context){
    SharedPreferences.getInstance().then((prefs){
      prefs.remove("sessionID").then((value){
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      });
    });
  }
  static void alert(BuildContext context, String title, String content){
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(title),
        content: Text(content),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(); // dismisses only the dialog and returns nothing
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }
}