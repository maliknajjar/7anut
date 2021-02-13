import 'dart:convert';

import 'package:flutter/material.dart';

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
          "Order Details",
          style: TextStyle(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
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
                        child: Text("orders"),
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
                              "Name: " + orders[i]["Name"] 
                              + "\nSize: " + orders[i]["size"].toString()
                              + "\nEach Price: " + orders[i]["price"].toString() + " DT"
                              + "\ntotal Price: " + (double.parse(orders[i]["price"]) * orders[i]["qty"]).toStringAsFixed(3) + " DT"
                              + "\nqty: " + orders[i]["qty"].toString()
                              + "\n"
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
                        child: Text("Address"),
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
                              address.keys.toList()[i].toString() + ": " + address.values.toList()[i].toString()
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
                        child: Text(data.keys.toList()[i].toString() == "totalPrice" ? "Subtotal" : data.keys.toList()[i].toString()),
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
                        child: Text(data.values.toList()[i].toString()),
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