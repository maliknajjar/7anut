import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

import '../Widgets/GPSWidget.dart';
import '../Widgets/ClassicAddressWidget.dart';

import './LoadingLogoScreen.dart';

import 'package:shop_app/Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';
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
          title: Text(Dictionairy.words["Add Address"][UserInformation.language], style: TextStyle(color: Colors.black.withOpacity(0.75)),),
          backgroundColor: Colors.yellow[200],
          bottom: TabBar(
            labelColor: Colors.black.withOpacity(0.75),
            unselectedLabelColor: Colors.black.withOpacity(0.75),
            indicatorColor: Colors.black.withOpacity(0.75),
            tabs: [
              Tab(icon: Text(Dictionairy.words["GPS Address"][UserInformation.language])),
              Tab(icon: Text(Dictionairy.words["Classic Address"][UserInformation.language])),
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