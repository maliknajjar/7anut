import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TheDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(child: Text('Drawer Header')),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('logout'),
            onTap: () {
              SharedPreferences.getInstance().then((prefs){
                prefs.remove("sessionID").then((value){
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                });
              });
            },
          ),
        ],
      ),
    );
  }
}