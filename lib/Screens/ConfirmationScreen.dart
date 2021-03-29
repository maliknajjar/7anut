import 'dart:convert';

import '../Classes/Basket.dart';
import '../Classes/Functions.dart';
import '../Classes/Dictionairy.dart';
import './LoadingLogoScreen.dart';
import '../Widgets/SuccessWidget.dart';
import '../env.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Classes/UserInformation.dart';
import 'package:google_fonts/google_fonts.dart';

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
    }).catchError((onError){
      print("Catch error");
      print(onError);
      Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
    });
  }
  @override
  Widget build(BuildContext context) {
    var theWidth = MediaQuery.of(context).size.width;
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments as Map;
    List address = args["Address"].values.toList();
    if(args["Address"].containsKey("location")){
      for (var i = 0; i < address.length; i++) {
        if(i == 2) address[i] = address[i]["latitude"].toStringAsFixed(5) + ", " + address[i]["longitude"].toStringAsFixed(5);
      }
    }
    address.removeAt(0);
    
    return !isDataHere 
    ? LoadingLogo()
    : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[200],
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        title: Text(
          Dictionairy.words["Confirmation"][UserInformation.language],
          style: GoogleFonts.almarai(
            color: Colors.black.withOpacity(0.75),
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
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  constraints: BoxConstraints(
                    maxWidth: 600
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Dictionairy.words["Orders"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold),),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              bottom: 20,
                              top: 10,
                            ),
                            padding: EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.yellow[100],
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7.5,
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.25),
                                  offset: Offset(2.5, 2.5),
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Table(
                                    columnWidths: {
                                      0: FlexColumnWidth(2.0),
                                      1: FlexColumnWidth(1.0),
                                      2: FlexColumnWidth(1.0),
                                      3: FlexColumnWidth(1.0),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          Text(Dictionairy.words["Name"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold),),
                                          Text(Dictionairy.words["size"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold),),
                                          Text(Dictionairy.words["qty"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold),),
                                          Text(Dictionairy.words["price"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold),),
                                        ]
                                      ),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      bottom: 20
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      bottom: 15
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[100],
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.yellow[100],
                                          Colors.yellow[50].withOpacity(0.25)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0.0, 1]
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7.5,
                                          spreadRadius: -0,
                                          color: Colors.black.withOpacity(0.15),
                                          offset: Offset(0, 5),
                                        ),
                                        BoxShadow(
                                          color: Colors.yellow[100],
                                        )
                                      ],
                                    ),
                                    child: Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(2.0),
                                        1: FlexColumnWidth(1.0),
                                        2: FlexColumnWidth(1.0),
                                        3: FlexColumnWidth(1.0),
                                      },
                                      children: [
                                        for (var i = 0; i < Basket.basketItems.length; i++)
                                        TableRow(
                                          children: [
                                            Text(Basket.basketItems[i]["Name"], style: GoogleFonts.almarai(fontSize: 18),),
                                            Text(Basket.basketItems[i]["size"], style: GoogleFonts.almarai(fontSize: 18),),
                                            Text(Basket.basketItems[i]["qty"].toString(), style: GoogleFonts.almarai(fontSize: 18),),
                                            Text((double.parse(Basket.basketItems[i]["price"]) * Basket.basketItems[i]["qty"]).toStringAsFixed(3), style: GoogleFonts.almarai(fontSize: 18),),
                                          ]
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  margin: EdgeInsets.only(top: 0),
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(Dictionairy.words["Subtotal"][UserInformation.language] + ":", style: GoogleFonts.almarai(fontSize: 16),),
                                          Text(Basket.getUltimateTotal().toStringAsFixed(3) + " DT", style: GoogleFonts.almarai(fontSize: 16),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(Dictionairy.words["transport fee"][UserInformation.language] + ":", style: GoogleFonts.almarai(fontSize: 16),),
                                          Text(theFee.toStringAsFixed(3) + " DT", style: GoogleFonts.almarai(fontSize: 16),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(Dictionairy.words["total"][UserInformation.language] + ":", style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold),),
                                          Text((Basket.getUltimateTotal() + theFee).toStringAsFixed(3) + " DT", style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold),),
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
                      Text(Dictionairy.words["Address"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold),),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          bottom: 20,
                          top: 10
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow[100],
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7.5,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(2.5, 2.5),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var item in address)
                            if(item.toString() != "null")
                            Text(item.toString(), style: GoogleFonts.almarai(fontSize: 18),),
                          ],
                        ),
                      ),
                      Text(Dictionairy.words["Payment Type"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold),),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          bottom: 20,
                          top: 10
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow[100],
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7.5,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(2.5, 2.5),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Dictionairy.words[args["Payment Type"].toString()] == null ? "null" : Dictionairy.words[args["Payment Type"].toString()][UserInformation.language], style: GoogleFonts.almarai(fontSize: 18),),
                          ],
                        ),
                      ),
                      Text(Dictionairy.words["Delivery Date"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold),),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          bottom: 10,
                          top: 10
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow[100],
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7.5,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(2.5, 2.5),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(args["Recieve Date"].toString(), style: GoogleFonts.almarai(fontSize: 18),),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                      print(value.body);
                      if(jsonDecode(value.body)["error"] != null){
                        Functions.logout(context, "Session is expired", Colors.red);
                        return;
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessWidget(),));
                      // Navigator.of(context).pushAndRemoveUntil('/home', (Route<dynamic> route) => false);
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SuccessWidget()), (route) => false);
                    });
                  }).catchError((onError){
                    print("Catch error");
                    print(onError);
                    Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
                  });
                },
                child: Container(
                  height: 60,
                  width: theWidth,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.yellow[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 7.5,
                        offset: Offset(0, 0),
                      ),
                    ]
                  ),
                  child: Center(
                    child: isPressed 
                    ? Image.asset("assets/images/theLoading.gif", height: 30)
                    : Text(Dictionairy.words["Order"][UserInformation.language] + "  ", style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold),),
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
