import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../Classes/Functions.dart';
import '../Classes/Adresses.dart';

import '../Widgets/GPSWidget.dart';
import '../Widgets/ClassicAddressWidget.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xFF303030),
          ),
          centerTitle: true,
          title: Image.asset(
            "assets/images/logo-01.png", 
            height: 25,
          ),
          backgroundColor: Color(0xFF5DA7E6),
          bottom: TabBar(
            labelColor: Color(0xFF303030),
            unselectedLabelColor: Color(0xFF303030),
            indicatorColor: Color(0xFFFCF555),
            tabs: [
              Tab(icon: Text("GPS Address")),
              Tab(icon: Text("Classic Address")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GPSAddAddress(),
            ClassicAddressWidget(),
          ],
        ),
      ),
    );
  }
}