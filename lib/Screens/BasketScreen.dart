import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

// classes
import '../Classes/Basket.dart';
import '../Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';
import '../Classes/Functions.dart';
import '../env.dart';

import 'package:google_fonts/google_fonts.dart';

class BasketScreen extends StatefulWidget {
  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  List<bool> isLoading = [];
  List<bool> isLoadingForMinus = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var i = 0; i < Basket.basketItems.length; i++) {
      isLoading.add(false);
      isLoadingForMinus.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Basket.basketItems.isEmpty ? Colors.white : Colors.white,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          } 
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[200],
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        title: Text(
          Dictionairy.words["Basket"][UserInformation.language],
          style: GoogleFonts.almarai(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
      ),
      body: Basket.basketItems.isEmpty 
      ? InkWell(
        onTap: (){
          Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
          Navigator.of(context).pushNamed("/category", arguments: 0);
        },
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(Dictionairy.words["Basket is empty"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, color: Colors.black.withOpacity(0.75)),),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.yellow[200],
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: -5,
                      color: Colors.black.withOpacity(0.35),
                      offset: Offset(5, 5),
                    )
                  ]
                ),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Dictionairy.words["Go to Market"][UserInformation.language], style: GoogleFonts.almarai(color: Colors.black.withOpacity(0.75), fontSize: 20),),
                      Container(child: Icon(Icons.arrow_forward, color: Colors.black.withOpacity(0.75)), margin: EdgeInsets.only(left: 10),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
      : Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 600
            ),
            // padding: EdgeInsets.only(bottom: double.infinity),
            margin: theWidth > 600 
            ? EdgeInsets.only(
              left: 20,
              right: 20,
            )
            : EdgeInsets.only(
              left: 0,
              right: 0,
            ),
            child: ListView(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 600,
                  margin: EdgeInsets.only(bottom: theWidth < 600 ? 50 : 125),
                  decoration: BoxDecoration(
                    color: Colors.yellow[50],
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ) // wooooooooooooooooooooooooooooow
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < Basket.basketItems.length; i++)
                        Container(
                          // padding: EdgeInsets.all(theWidth < 600 ? 15 : 15),
                          padding: EdgeInsets.only(
                            bottom: i == Basket.basketItems.length - 1 ? 30 : 15,
                            left: 15,
                            right: 15,
                            top: 15
                          ),
                          margin: EdgeInsets.only(bottom: i == Basket.basketItems.length - 1 ? 0 : 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.75),
                                Colors.yellow[50],
                              ],
                              stops: [
                                0,
                                1,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: -10,
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(0, 15),
                              ),
                              BoxShadow(
                                color: Colors.yellow[50],
                              )
                            ],
                            borderRadius: i == Basket.basketItems.length - 1 && theWidth > 600
                            ? BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )
                            : BorderRadius.circular(0)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      Basket.basketItems[i]["imageUrl"],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.25),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              Basket.basketItems[i]["Name"],
                                              style: GoogleFonts.almarai(fontSize: 15),
                                            ),
                                          ),
                                          Text(
                                            Basket.basketItems[i]["price"] + " DT",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700]
                                            ),
                                          ),
                                          Text(
                                            Basket.basketItems[i]["size"],
                                            style: GoogleFonts.almarai(
                                              fontSize: 15,
                                              color: Colors.grey[700]
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Total: " + (double.parse(Basket.basketItems[i]["price"]) * Basket.basketItems[i]["qty"]).toStringAsFixed(2) + " DT",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 105,
                                width: 90,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.yellow[100],
                                          ),
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 5,
                                            spreadRadius: -2.5,
                                            offset: Offset(2.5, 2.5),
                                          ),
                                          BoxShadow(
                                            color: Colors.yellow[100].withOpacity(0.75),
                                            blurRadius: 5,
                                            spreadRadius: -2.5,
                                            offset: Offset(2.5, 2.5),
                                          ),
                                        ],
                                      ),
                                      child: Center(child: Text(Basket.basketItems[i]["qty"].toString(), style: TextStyle(fontSize: 30),)),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if(isLoading[i] == false){  // to prevent the user from clicking while loading
                                                setState(() {
                                                  isLoading[i] = true;
                                                });
                                                http.post(env.apiUrl + "/api/takeproduct", body: {
                                                  "email": UserInformation.email, 
                                                  "sessionID": UserInformation.sessionID, 
                                                  "ID": Basket.basketItems[i]["ID"].toString(),
                                                  "basket": jsonEncode(Basket.addToSimpleFuture(Basket.basketItems[i]["ID"].toString()))
                                                })
                                                .then((value){
                                                  if(value.body.contains("error")){
                                                    Functions.logout(context, Dictionairy.words[jsonDecode(value.body)["error"]][UserInformation.language], Colors.red);
                                                    return;
                                                  }
                                                  // cancel every thing if limit is reached
                                                  if(jsonDecode(value.body)["msg"] == "reached limit"){
                                                    Functions.showTheDialogue(context, "limit per user");
                                                    setState(() {
                                                      isLoading[i] = false;
                                                    });
                                                    return;
                                                  }
                                                  if(jsonDecode(value.body)["msg"] == "product finished"){
                                                    setState(() {
                                                      isLoading[i] = false;
                                                    });
                                                    Functions.showTheDialogue(context, "this product is out of stock");
                                                    return;
                                                  }
                                                  setState(() {
                                                    isLoading[i] = false;
                                                    Basket.addItem(Basket.basketItems[i]["ID"], Basket.basketItems[i]["Name"], Basket.basketItems[i]["size"], Basket.basketItems[i]["imageUrl"], Basket.basketItems[i]["price"].toString(), Basket.basketItems[i]["limit_amount_per_user"]);
                                                  });
                                                });
                                              }
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 35,
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
                                              child: isLoading[i]
                                              ? Image.asset("assets/images/theLoading.gif", scale: 12,)
                                              : Icon(
                                                Icons.add
                                              )
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if(isLoadingForMinus[i] == false){  // to prevent the user from clicking while loading
                                                setState(() {
                                                  isLoadingForMinus[i] = true;
                                                });
                                                http.post(env.apiUrl + "/api/leaveproduct", body: {
                                                  "email": UserInformation.email, 
                                                  "sessionID": UserInformation.sessionID, 
                                                  "ID": Basket.basketItems[i]["ID"].toString(),
                                                  "basket": jsonEncode(Basket.removeFromSimpleFuture(Basket.basketItems[i]["ID"].toString()))
                                                })
                                                .then((value){
                                                  if(value.body.contains("error")){
                                                    Functions.logout(context, Dictionairy.words[jsonDecode(value.body)["error"]][UserInformation.language], Colors.red);
                                                    return;
                                                  }
                                                  setState(() {
                                                    isLoadingForMinus[i] = false;
                                                    Basket.removeItem(Basket.basketItems[i]["ID"]);
                                                  });
                                                });
                                              }
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(2, 2),
                                                  ),
                                                ],
                                              ),
                                              child: isLoadingForMinus[i]
                                              ? Image.asset("assets/images/theLoading.gif", scale: 12,)
                                              : Icon(
                                                Icons.remove
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed("/checkout");
                },
                child: Container(
                  height: 60, 
                  decoration: BoxDecoration(
                    color: Colors.yellow[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(margin: EdgeInsets.only(bottom: 0), child: Text(Dictionairy.words["Checkout"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75)),)),
                          Text(Basket.getUltimateTotal().toStringAsFixed(2) + " DT", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75)),)
                        ],
                      ),
                      Container(child: Icon(Icons.arrow_forward), margin: EdgeInsets.only(left: 10),),
                    ],
                  )
                ),
              ),
            )
          ],
        ),
      );
  }
}
