import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xFF303030),
        ),
        title: Text(
          "checkout",
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
        backgroundColor: Color(0xFF5DA7E6),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 10
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Deliver to", style: TextStyle(fontSize: 20),),
                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (context){
                          return SimpleDialog(
                            contentPadding: EdgeInsets.all(15),
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, "/addaddress");
                                },
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.add_location_alt_outlined, color: Colors.blue,),
                                      Text("Add Address", style: TextStyle(fontSize: 20, color: Colors.blue),),
                                    ],
                                  ),
                                ),
                              ),
                              for (var i = 0; i < 5; i++)
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 10
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                padding: EdgeInsets.all(15),
                                child: Text("data", style: TextStyle(fontSize: 20),),
                              ),
                            ],
                          );
                        }
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose address", style: TextStyle(fontSize: 20),),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
