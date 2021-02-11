import 'package:flutter/material.dart';

import '../Classes/Adresses.dart';

import '../Classes/Functions.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var chosenAddress;
  String payWith;
  String recieveAtTime;

  String addressName;


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toUtc().add(Duration(hours: 1));

    var theWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        title: Text(
          "checkout",
          style: TextStyle(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        backgroundColor: Colors.yellow[200],
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 7.5,
                bottom: 75,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 25
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7.5,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(2.5, 2.5),
                          )
                        ]
                      ),
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 20,
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Deliver to", style: TextStyle(fontSize: 20),),
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context){
                                  return StatefulBuilder(
                                    builder: (context, setState){
                                      return SimpleDialog(
                                        contentPadding: EdgeInsets.all(15),
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushNamed(context, "/addaddress").then((value){
                                                setState(() {
                                                                                      
                                                });
                                              });
                                            },
                                            child: Container(
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
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.add_location_alt_outlined, color: Colors.blue,),
                                                  Text("Add Address", style: TextStyle(fontSize: 20, color: Colors.blue),),
                                                ],
                                              ),
                                            ),
                                          ),
                                          for (var i = 0; i < Addresses.getCurrentUserAddresses().length; i++)
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).pop(i);
                                            },
                                            child: Container(
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
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(Addresses.getCurrentUserAddresses()[i]["title"], style: TextStyle(fontSize: 20),),
                                                  Icon(Icons.location_on_outlined)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                }
                              ).then((value){
                                if(value != null){
                                  setState((){
                                    chosenAddress = Addresses.getCurrentUserAddresses()[value];
                                    addressName = Addresses.getCurrentUserAddresses()[value]["title"];
                                    print(chosenAddress);
                                  });
                                }
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 15),
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
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(addressName == null ? "Choose Address" : addressName, style: TextStyle(fontSize: 20),),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 25
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
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
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 20,
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pay With", style: TextStyle(fontSize: 20),),
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context){
                                  return StatefulBuilder(
                                    builder: (context, setState){
                                      return SimpleDialog(
                                        contentPadding: EdgeInsets.all(15),
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).pop("Cash");
                                            },
                                            child: Container(
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
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Cash", style: TextStyle(fontSize: 20),),
                                                  Icon(Icons.payments_outlined)
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              // Navigator.of(context).pop("Credit Card");
                                            },
                                            child: Container(
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
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Credit Card (soon)", style: TextStyle(fontSize: 20, color: Colors.grey),),
                                                  Icon(Icons.payment_outlined, color: Colors.grey,)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                }
                              ).then((value){
                                setState((){
                                  payWith = value;
                                  print(payWith);
                                });
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 15),
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
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(payWith == null ? "Choose Payment" : payWith, style: TextStyle(fontSize: 20),),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 20
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
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
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 20,
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Recieve at", style: TextStyle(fontSize: 20),),
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context){
                                  return StatefulBuilder(
                                    builder: (context, setState){
                                      return SimpleDialog(
                                        contentPadding: EdgeInsets.all(15),
                                        children: [
                                          for (var i = 1; i < 8; i++)
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).pop(DateTime(now.year, now.month, now.day + i).toString().substring(0, 10));
                                            },
                                            child: Container(
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
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(DateTime(now.year, now.month, now.day + i).toString().substring(0, 10) + (i == 1 ? " (Tomorrow)" : ""), style: TextStyle(fontSize: 20),),
                                                  Icon(Icons.date_range_outlined)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                }
                              ).then((value){
                                setState((){
                                  recieveAtTime = value;
                                });
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 15),
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
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(recieveAtTime == null ? "Choose Time" : recieveAtTime, style: TextStyle(fontSize: 20),),
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
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: (){
                  if(chosenAddress == null || payWith == null || recieveAtTime == null){
                    Functions.alert(context, "fill the fields", "you need to fill all the fields");
                    return;
                  }
                  var information = {"Address": chosenAddress, "Payment Type": payWith, "Recieve Date": recieveAtTime};
                  Navigator.of(context).pushNamed("/confirmation", arguments: information);
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
                    child: Text("Next", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
