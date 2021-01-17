import 'package:flutter/material.dart';

import '../Classes/Adresses.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String chosenAddress;

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
                                      Navigator.of(context).pop(Addresses.addressesBasket[i]["title"]);
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
                        setState((){
                          chosenAddress = value;
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
                          Text(chosenAddress == null ? "Choose Address" : chosenAddress, style: TextStyle(fontSize: 20),),
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
                                      Navigator.of(context).pop(Addresses.addressesBasket[0]["title"]);
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
                                          Text(Addresses.addressesBasket[0]["title"], style: TextStyle(fontSize: 20),),
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
                        setState((){
                          chosenAddress = value;
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
                          Text(chosenAddress == null ? "Choose Payment" : chosenAddress, style: TextStyle(fontSize: 20),),
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
