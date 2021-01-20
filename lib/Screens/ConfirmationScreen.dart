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
                    Text("address"),
                    Column(
                      children: [
                        Text(args[i]["title"]),
                        Text(args[i]["information"]),
                        Text(args[i]["instructions"]),
                        Text(args[i]["location"]["latitude"].toString() + "   " + args[i]["location"]["longitude"].toString()),
                      ],
                    ),
                  ],
                )
              else if (i == 1) 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("payment type"),
                    Container(
                      child: Text(args[i]),
                    ),
                  ],
                )
              else if (i == 2) 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("recieve date"),
                    Container(
                      child: Text(args[i]),
                    ),
                  ],
                )
          ],
        ),
      )
    );
  }
}
