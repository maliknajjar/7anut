import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            for(var n = 0; n < 10; n++)
            Container(
              margin: EdgeInsets.only(top: 0, bottom: 20, right: 20, left: 20,),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Order ID: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        TextSpan(text: '1654', style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Order date: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        TextSpan(text: '23.02.2015', style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Paid amount: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        TextSpan(text: '120 USD', style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Delivery date: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        TextSpan(text: '24.02.2015', style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'status: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        TextSpan(text: 'coming', style: TextStyle(fontSize: 20, color: Colors.yellow[700]),),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
