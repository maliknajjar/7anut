import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

import '../Widgets/GPSWidget.dart';
import '../Widgets/ClassicAddressWidget.dart';

import './LoadingLogoScreen.dart';

import '../env.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isDataHere = false;
  List<dynamic> r;

  @override
    void initState() {
      super.initState();

      http.get(env.apiUrl + "/api/cities")
      .then((value){
        r = jsonDecode(value.body);
        setState(() {
          isDataHere = true;
        });
      });
    }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      initialIndex: kIsWeb ? 1 : 0,
      child: !isDataHere ? LoadingLogo() : Scaffold(
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
            GPSAddAddress(r),
            ClassicAddressWidget(r),
          ],
        ),
      ),
    );
  }
}