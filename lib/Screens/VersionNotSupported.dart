import 'package:flutter/material.dart';

class VersionNotSupported extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("your version is not supported"),
      ),
    );
  }
}