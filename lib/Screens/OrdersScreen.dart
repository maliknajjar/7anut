import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../env.dart';
import '../Classes/UserInformation.dart';

import './LoadingLogoScreen.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isDataHere = false;
  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    http.post(env.apiUrl + "/api/getuserorders", body: {
      "email": UserInformation.email,
      "sessionID": UserInformation.sessionID,
    })
    .then((value){
      print(value.body);
      setState(() {
        isDataHere = true;
        data = jsonDecode(value.body);
      });
    });
  }

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
          "Orders",
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
      ),
      body: !isDataHere ? LoadingLogo() : SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            for(var n = 0; n < data.length; n++)
            Container(
              // padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black.withOpacity(0.5)
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("10-15-2021", style: TextStyle(fontSize: 18),),
                        Row(
                          children: [
                            Text("Active", style: TextStyle(fontSize: 18),),
                            Container(
                              margin: EdgeInsets.only(
                                left: 5
                              ),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: BorderDirectional(bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.5),),)
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
