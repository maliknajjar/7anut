import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../Classes/Basket.dart';
import '../Classes/Functions.dart';
import '../env.dart';

import './LoadingLogoScreen.dart';
import '../Widgets/SuccessWidget.dart';

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool isDataHere = false;
  bool isPressed = false;
  double theFee;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http.get(env.apiUrl + "/api/fee")
    .then((value){
      var responce = jsonDecode(value.body);
      for (var i = responce.length-1; i < responce.length; i--) {
        if(Basket.getUltimateTotal() >= responce[i]["biggerThan"]){
          setState(() {
          theFee = responce[i]["fee"].toDouble();
          isDataHere = true;
          });
          return;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var theWidth = MediaQuery.of(context).size.width;
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments as Map;
    List address = args["Address"].values.toList();
    if(args["Address"].containsKey("location")){
      for (var i = 0; i < address.length; i++) {
        if(i == 1) address[i] = address[i]["latitude"].toStringAsFixed(5) + ", " + address[i]["longitude"].toStringAsFixed(5);
      }
    }
    address.removeAt(0);
    
    return !isDataHere 
    ? LoadingLogo()
    : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF5DA7E6),
        iconTheme: IconThemeData(
          color: Color(0xFF303030),
        ),
        title: Text(
          "Confirmation",
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: 75
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Orders", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            bottom: 10,
                            top: 10
                          ),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2
                            )
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Table(
                                  children: [
                                    TableRow(
                                      children: [
                                        Text("Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                        Text("size", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                        Text("qty", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                        Text("price", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                      ]
                                    ),
                                  ],
                                ),
                              ),
                              Table(
                                children: [
                                  for (var i = 0; i < Basket.basketItems.length; i++)
                                  TableRow(
                                    children: [
                                      Text(Basket.basketItems[i]["Name"], style: TextStyle(fontSize: 18),),
                                      Text(Basket.basketItems[i]["size"], style: TextStyle(fontSize: 18),),
                                      Text(Basket.basketItems[i]["qty"].toString(), style: TextStyle(fontSize: 18),),
                                      Text((double.parse(Basket.basketItems[i]["price"]) * Basket.basketItems[i]["qty"]).toStringAsFixed(3), style: TextStyle(fontSize: 18),),
                                    ]
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                margin: EdgeInsets.only(top: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: BorderDirectional(
                                    top: BorderSide(
                                      width: 1,
                                    )
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Subtotal:", style: TextStyle(fontSize: 16),),
                                        Text(Basket.getUltimateTotal().toStringAsFixed(3) + " DT", style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("transport fee:", style: TextStyle(fontSize: 16),),
                                        Text(theFee.toStringAsFixed(3) + " DT", style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("total:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                        Text((Basket.getUltimateTotal() + theFee).toStringAsFixed(3) + " DT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                    Text("Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: 10,
                        top: 10
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var item in address)
                          if(item.toString() != "null")
                          Text(item.toString(), style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                    Text("Payment Type", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: 10,
                        top: 10
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(args["Payment Type"].toString(), style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                    Text("Delivery Date", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: 10,
                        top: 10
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(args["Recieve Date"].toString(), style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    isPressed = true;
                  });
                  SharedPreferences.getInstance().then((prefs){
                    http.post(env.apiUrl + "/api/addOrder",
                    headers: {"Content-Type": "application/json"},
                    body: json.encode({
                      "sessionID": prefs.getString("sessionID"),
                      "email": prefs.getString("email"),
                      "orders": jsonEncode(Basket.basketItems),
                      "transportFee": double.parse(theFee.toStringAsFixed(3)),
                      "totalPrice": double.parse((Basket.getUltimateTotal() + theFee).toStringAsFixed(3)),
                      "address": jsonEncode(args["Address"]),
                      "paymentType": args["Payment Type"].toString(),
                      "recieveDate": args["Recieve Date"].toString(),
                    }))
                    .then((value){
                      if(jsonDecode(value.body)["error"] != null){
                        Functions.logout(context);
                        return;
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessWidget(),));
                    });
                  });
                },
                child: Container(
                  height: 60,
                  width: theWidth,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border(
                      top: BorderSide(
                        width: 2,
                        color: Colors.black
                      )
                    )
                  ),
                  child: Center(
                    child: Text(isPressed ? "Loading..." : "Order", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
