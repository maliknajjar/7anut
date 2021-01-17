import 'package:flutter/material.dart';

import '../Classes/Adresses.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var chosenAddress;
  String payWith;

  String addressName;

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
                                  for (var i = 0; i < Addresses.addressesBasket.length; i++)
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
                                          Text(Addresses.addressesBasket[i]["title"], style: TextStyle(fontSize: 20),),
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
                            chosenAddress = Addresses.addressesBasket[value];
                            addressName = Addresses.addressesBasket[value]["title"];
                            print(chosenAddress);
                          });
                        }
                      });
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
                                          Text("Credit Card (coming soon)", style: TextStyle(fontSize: 20, color: Colors.grey),),
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
                        });
                      });
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
                          Text(payWith == null ? "Choose Payment" : payWith, style: TextStyle(fontSize: 20),),
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
