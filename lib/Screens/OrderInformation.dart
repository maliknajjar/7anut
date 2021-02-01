import 'dart:convert';

import 'package:flutter/material.dart';

class OrderInformation extends StatelessWidget {
  Map data;

  OrderInformation(var theData){
    data = theData;
    data.remove("userEmail");
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
          "Order Information",
          style: TextStyle(
            color: Color(0xFF303030),
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
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(4),
                },
                // textDirection: TextDirection.rtl,
                // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                border:TableBorder.all(width: 1.0, color: Colors.black.withOpacity(0.5)),
                children: [
                  for (var i = 0; i < data.length; i++)
                  TableRow(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(data.keys.toList()[i].toString()),
                      ),
                      Container(
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