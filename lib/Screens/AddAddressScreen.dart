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
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.75),
          ),
          centerTitle: true,
          title: Image.asset(
            "assets/images/logo-01.png", 
            height: 25,
          ),
          backgroundColor: Colors.yellow[200],
          bottom: TabBar(
            labelColor: Colors.black.withOpacity(0.75),
            unselectedLabelColor: Colors.black.withOpacity(0.75),
            indicatorColor: Colors.black.withOpacity(0.75),
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