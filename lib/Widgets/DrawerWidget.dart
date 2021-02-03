import 'package:flutter/material.dart';
import '../Classes/Functions.dart';

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
              Functions.logout(context, null, null);
            },
          ),
        ],
      ),
    );
  }
}