import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderInformation extends StatelessWidget {
  Map data;
  List orders;
  Map address;

  OrderInformation(var theData){
    data = theData;
    orders = jsonDecode(data["orders"]);
    address = jsonDecode(data["address"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[200],
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        title: Text(
          Dictionairy.words["Order Details"][UserInformation.language],
          style: GoogleFonts.almarai(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 600,
          ),
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(4),
                },
                children: [
                  TableRow(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 10
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellow[50],
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7.5,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(2.5, 2.5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(Dictionairy.words["Orders"][UserInformation.language], style: GoogleFonts.almarai(),),
                      ),
                      Container(
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
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < orders.length; i++)
                            Text(
                              Dictionairy.words["Name"][UserInformation.language] + ": " + orders[i]["Name"] 
                              + "\n" + Dictionairy.words["size"][UserInformation.language] + ": " + orders[i]["size"].toString()
                              + "\n" + Dictionairy.words["price"][UserInformation.language] + ": " + orders[i]["price"].toString() + " DT"
                              + "\n" + Dictionairy.words["total"][UserInformation.language] + ": " + (double.parse(orders[i]["price"]) * orders[i]["qty"]).toStringAsFixed(3) + " DT"
                              + "\n" + Dictionairy.words["qty"][UserInformation.language] + ": " + orders[i]["qty"].toString()
                              + "\n", style: GoogleFonts.almarai(),
                            ),
                          ],
                        ),
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 10
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellow[50],
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7.5,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(2.5, 2.5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(Dictionairy.words["Address"][UserInformation.language], style: GoogleFonts.almarai(),),
                      ),
                      Container(
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
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < address.length; i++)
                            Text(
                              Dictionairy.words[address.keys.toList()[i].toString()][UserInformation.language] + ": " + (address.values.toList()[i].toString().contains("{latitude: ") ? address.values.toList()[i].toString().toString().replaceAll("{", "").replaceAll("}", "").replaceAll("latitude: ", "").replaceAll("longitude: ", "").replaceAll(", ", " ") : address.values.toList()[i].toString()), style: GoogleFonts.almarai(),
                            ),
                          ],
                        ),
                      )
                    ]
                  ),
                  for (var i = 0; i < data.length; i++)
                  if(data.keys.toList()[i].toString() != "address" && data.keys.toList()[i].toString() != "orders" && data.keys.toList()[i].toString() != "ID")
                  TableRow(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 10
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellow[50],
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7.5,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(2.5, 2.5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(data.keys.toList()[i].toString() == "totalPrice" ? Dictionairy.words["Subtotal"][UserInformation.language] : Dictionairy.words[data.keys.toList()[i].toString()][UserInformation.language], style: GoogleFonts.almarai(),),
                      ),
                      Container(
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
                        margin: EdgeInsets.all(10),
                        child: Text(data.values.toList()[i].toString() == "Cash" ? Dictionairy.words[data.values.toList()[i].toString()][UserInformation.language] : data.values.toList()[i].toString().contains('"status":') ? Dictionairy.words[jsonDecode(data.values.toList()[i].toString())["status"]][UserInformation.language] : data.values.toList()[i].toString(), style: GoogleFonts.almarai(),),
                      )
                    ]
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}