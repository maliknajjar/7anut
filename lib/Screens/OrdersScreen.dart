import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../env.dart';
import '../Classes/Functions.dart';
import '../Classes/UserInformation.dart';

import './LoadingLogoScreen.dart';
import './OrderInformation.dart';

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
      print({
      "email": UserInformation.email,
      "sessionID": UserInformation.sessionID,
      });
      print(value.body);
      if(value.body.contains("error")){
        Functions.logout(context, "Session is expired", Colors.red);
        return;
      }
      setState(() {
        isDataHere = true;
        data = jsonDecode(value.body).reversed.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget space = Container(height: 10,);

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
            InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => OrderInformation(data[n])),);
              },
              child: Container(
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
                      padding: EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                        left: 15,
                        right: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(data[n]["status"], style: TextStyle(fontSize: 16),),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(data[n]["orderTime"].split(" ")[0], style: TextStyle(fontSize: 16),),
                              Text(data[n]["orderTime"].split(" ")[1], style: TextStyle(fontSize: 14),),
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
                          Row(
                            children: [
                              Text("Order ID:", style: TextStyle(fontWeight: FontWeight.bold),),
                              Container(
                                child: Text(data[n]["orderID"]),
                                margin: EdgeInsets.only(
                                  left: 10
                                ),
                              ),
                            ],
                          ),
                          space,
                          Row(
                            children: [
                              Text("Total", style: TextStyle(fontWeight: FontWeight.bold),),
                              Container(
                                child: Text((data[n]["transportFee"] + data[n]["totalPrice"]).toString() + " DT"),
                                margin: EdgeInsets.only(
                                  left: 10
                                ),
                              ),
                            ],
                          ),
                          space,
                          Row(
                            children: [
                              Text("Address:", style: TextStyle(fontWeight: FontWeight.bold),),
                              Container(
                                child: Text(jsonDecode(data[n]["address"])["title"]),
                                margin: EdgeInsets.only(
                                  left: 10
                                ),
                              ),
                            ],
                          ),
                          space,
                          Row(
                            children: [
                              Text("Payment Type:", style: TextStyle(fontWeight: FontWeight.bold),),
                              Container(
                                child: Text(data[n]["paymentType"]),
                                margin: EdgeInsets.only(
                                  left: 10
                                ),
                              ),
                            ],
                          ),
                          space,
                          Row(
                            children: [
                              Text("delivery date:", style: TextStyle(fontWeight: FontWeight.bold),),
                              Container(
                                child: Text(data[n]["recieveDate"]),
                                margin: EdgeInsets.only(
                                  left: 10
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
