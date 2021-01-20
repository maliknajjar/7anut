import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as List;
    print(args);
    
    return Scaffold(
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
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 3; i++)
              if (i == 0) 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          Text("title: " + args[i]["title"], style: TextStyle(fontSize: 16),),
                          Text("information: " + (args[i]["information"] == null ? "none" : args[i]["information"]), style: TextStyle(fontSize: 16),),
                          Text("instructions: " + (args[i]["instructions"] == null ? "none" : args[i]["instructions"]), style: TextStyle(fontSize: 16),),
                          Text("location: " + args[i]["location"]["latitude"].toString().substring(0, 7) + "   " + args[i]["location"]["longitude"].toString().substring(0, 7), style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                  ],
                )
              else if (i == 1) 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Payment", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                          Text("Payment type: " + args[i], style: TextStyle(fontSize: 16),),
                        ]
                      ),
                    ),
                  ],
                )
              else if (i == 2) 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Arrival date", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                          Text("date: " + args[i] + " (tomorrow)", style: TextStyle(fontSize: 16),),
                        ]
                      ),
                    ),
                  ],
                )
          ],
        ),
      )
    );
  }
}
