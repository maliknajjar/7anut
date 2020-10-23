import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF5DA7E6),
        iconTheme: IconThemeData(
          color: Color(0xFF303030),
        ),
        title: Text(
          "Basket",
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Text("test"),
        )
      ),
    );
  }
}
