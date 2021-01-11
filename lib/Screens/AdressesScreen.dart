import 'package:flutter/material.dart';

class AdressesScreen extends StatefulWidget {
  @override
  _AdressesScreenState createState() => _AdressesScreenState();
}

class _AdressesScreenState extends State<AdressesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xFF303030),
        ),
        title: Text(
          "Adresses",
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
        backgroundColor: Color(0xFF5DA7E6),
      ),
      body: Container(
        child: Center(
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed("/GetLocation");
            },
            child: Text("click here to go to the GEt Location page"),
          ),
        ),
      ),
    );
  }
}
