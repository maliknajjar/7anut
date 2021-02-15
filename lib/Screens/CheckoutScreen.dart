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
                        gradient: LinearGradient(
                          colors: [
                            Colors.yellow[50],
                            Colors.yellow[100], 
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
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
                              showDialog(context: context, builder: (BuildContext context){
                                return StatefulBuilder(
                                  builder: (context, setState){
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.yellow[100],
                                      child: SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.pushNamed(context, "/addaddress").then((value){
                                                          setState(() {
                                                            
                                                          });
                                                        });
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.all(3),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12),
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Colors.black.withOpacity(0.1),
                                                              Colors.black.withOpacity(0.05),
                                                            ],
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                          ),
                                                        ),
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          padding: EdgeInsets.symmetric(
                                                            vertical: 10,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.8),
                                                            borderRadius: BorderRadius.circular(10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.yellow
                                                              )
                                                            ]
                                                          ),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text("Add Address", style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.75)),),
                                                              Icon(Icons.add_location_outlined, color: Colors.black.withOpacity(0.75),)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Addresses.getCurrentUserAddresses().length != 0
                                                    ? Container(
                                                      margin: EdgeInsets.only(bottom: 10, top: 20),
                                                      child: Text("Addresses: ", style: TextStyle(fontSize: 20),),
                                                    ) 
                                                    : Container(
                                                      padding: EdgeInsets.all(30),
                                                      alignment: Alignment.center,
                                                      child: Text("There are no Addesses", style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.5)),)
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
                                                          color: Colors.yellow[50],
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Colors.yellow[50],
                                                              Colors.yellow[100],
                                                            ],
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 5,
                                                              spreadRadius: 1,
                                                              color: Colors.black.withOpacity(0.2),
                                                              offset: Offset(2.5, 2.5),
                                                            )
                                                          ],
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    );
                                  },
                                );
                              }).then((value){
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
                        gradient: LinearGradient(
                          colors: [
                            Colors.yellow[50],
                            Colors.yellow[100], 
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
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
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.yellow[100],
                                        child: SingleChildScrollView(
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                            color: Colors.yellow[50],
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                Colors.yellow[50],
                                                                Colors.yellow[100],
                                                              ],
                                                              begin: Alignment.topCenter,
                                                              end: Alignment.bottomCenter,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 5,
                                                                spreadRadius: 1,
                                                                color: Colors.black.withOpacity(0.2),
                                                                offset: Offset(2.5, 2.5),
                                                              )
                                                            ],
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
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){
                                                          // Navigator.of(context).pop("Credit Card");
                                                        },
                                                        child: Container(
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(
                                                            color: Colors.yellow[50],
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                Colors.yellow[50],
                                                                Colors.yellow[100],
                                                              ],
                                                              begin: Alignment.topCenter,
                                                              end: Alignment.bottomCenter,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 5,
                                                                spreadRadius: 1,
                                                                color: Colors.black.withOpacity(0.2),
                                                                offset: Offset(2.5, 2.5),
                                                              )
                                                            ],
                                                            borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          padding: EdgeInsets.all(15),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("Credit Card (soon)", style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.5)),),
                                                              Icon(Icons.payment_outlined, color: Colors.black.withOpacity(0.5)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
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
                        gradient: LinearGradient(
                          colors: [
                            Colors.yellow[50],
                            Colors.yellow[100], 
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
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
                          Text("Deliver at", style: TextStyle(fontSize: 20),),
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context){
                                  return StatefulBuilder(
                                    builder: (context, setState){
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.yellow[100],
                                        child: SingleChildScrollView(
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                for (var i = 1; i < 8; i++)
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
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
                                                            color: Colors.yellow[50],
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                Colors.yellow[50],
                                                                Colors.yellow[100],
                                                              ],
                                                              begin: Alignment.topCenter,
                                                              end: Alignment.bottomCenter,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 5,
                                                                spreadRadius: 1,
                                                                color: Colors.black.withOpacity(0.2),
                                                                offset: Offset(2.5, 2.5),
                                                              )
                                                            ],
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
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
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
                                  Text(recieveAtTime == null ? "Choose Date" : recieveAtTime, style: TextStyle(fontSize: 20),),
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
