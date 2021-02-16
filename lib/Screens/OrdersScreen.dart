import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../env.dart';
import '../Classes/Functions.dart';
import '../Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';

import './LoadingLogoScreen.dart';
import './OrderInformation.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isDataHere = false;
  List data;

  void requestData(){
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
  void initState() {
    // TODO: implement initState
    super.initState();

    requestData();
  }

  @override
  Widget build(BuildContext context) {
    Widget space = Container(height: 10,);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[200],
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        title: Text(
          Dictionairy.words["Orders"][UserInformation.language],
          style: GoogleFonts.almarai(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              requestData();
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: !isDataHere 
      ? LoadingLogo() 
      : SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: data.isEmpty 
        ? Container(
          height: height - 100,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(Dictionairy.words["You have no orders"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 22),),
            ],
          )
        )
        : Column(
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
                  color: Colors.yellow[50],
                  borderRadius: BorderRadius.circular(10),
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
                      padding: EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                        left: 15,
                        right: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellow[50],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7.5,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(0.15),
                            offset: Offset(2.5, 2.5),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(Dictionairy.words[jsonDecode(data[n]["status"])["status"]][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 5
                                ),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.black.withOpacity(0.5)),
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(jsonDecode(data[n]["status"])["color"]["r"], jsonDecode(data[n]["status"])["color"]["g"], jsonDecode(data[n]["status"])["color"]["b"], 1),
                                ),
                              ),
                              jsonDecode(data[n]["status"])["message"] == null 
                              ? Text("")
                              : InkWell(
                                onTap: (){
                                  Functions.alert(context, "Information", jsonDecode(data[n]["status"])["message"]);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 15
                                  ),
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.5, color: Colors.black.withOpacity(0.75)),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(child: Text("?", style: GoogleFonts.almarai(fontWeight: FontWeight.bold),)),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(data[n]["orderTime"].split(" ")[0], style: GoogleFonts.almarai(fontSize: 16),),
                              Text(data[n]["orderTime"].split(" ")[1], style: GoogleFonts.almarai(fontSize: 14),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(Dictionairy.words["Order ID"][UserInformation.language] + ":", style: GoogleFonts.almarai(fontWeight: FontWeight.bold),),
                              Container(
                                child: Text(data[n]["orderID"], style: GoogleFonts.almarai(),),
                                margin: EdgeInsets.only(
                                  left: 10
                                ),
                              ),
                            ],
                          ),
                          space,
                          Row(
                            children: [
                              Text(Dictionairy.words["total"][UserInformation.language] + ":", style: GoogleFonts.almarai(fontWeight: FontWeight.bold),),
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
                              Text(Dictionairy.words["Address"][UserInformation.language] + ":", style: GoogleFonts.almarai(fontWeight: FontWeight.bold),),
                              Container(
                                child: Text(jsonDecode(data[n]["address"])["title"], style: GoogleFonts.almarai(),),
                                margin: EdgeInsets.only(
                                  left: 10
                                ),
                              ),
                            ],
                          ),
                          space,
                          Row(
                            children: [
                              Text(Dictionairy.words["Payment Type"][UserInformation.language] + ":", style: GoogleFonts.almarai(fontWeight: FontWeight.bold),),
                              Container(
                                child: Text(Dictionairy.words[data[n]["paymentType"]][UserInformation.language], style: GoogleFonts.almarai(),),
                                margin: EdgeInsets.only(
                                  left: 10
                                ),
                              ),
                            ],
                          ),
                          space,
                          Row(
                            children: [
                              Text(Dictionairy.words["Delivery Date"][UserInformation.language] + ":", style: GoogleFonts.almarai(fontWeight: FontWeight.bold),),
                              Container(
                                child: Text(data[n]["recieveDate"], style: GoogleFonts.almarai(),),
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
