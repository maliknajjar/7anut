import 'package:flutter/material.dart';
import '../Classes/Functions.dart';

class TheDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.orange,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.pink,
                padding: EdgeInsets.all(15),
                child: Text("data"),
              )
            ],
          ),
        ),
      ),
    );
  }
}