import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../Classes/Adresses.dart';
import '../Classes/UserInformation.dart';
import '../Classes/Adresses.dart';
import '../Classes/Dictionairy.dart';
import '../Classes/Functions.dart';
import '../env.dart';

class AdressesScreen extends StatefulWidget {
  @override
  _AdressesScreenState createState() => _AdressesScreenState();
}

class _AdressesScreenState extends State<AdressesScreen> {
  bool refreshIsRequired = false;

  @override
  Widget build(BuildContext context) {
    List addresses = Addresses.addressesBasket;

    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context, refreshIsRequired == true ? "refresh" : null);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.75),
          ),
          title: Text(
            Dictionairy.words["Addresses"][UserInformation.language],
            style: GoogleFonts.almarai(
              color: Colors.black.withOpacity(0.75),
            ),
          ),
          backgroundColor: Colors.yellow[200],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_location_alt_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("/addaddress", arguments: "new").then((value){  
                  setState(() {
                    if(value == "refresh") refreshIsRequired = true;
                  });
                });
              },
            )
          ],
        ),
        body: addresses.isEmpty // check if there are addresses
          ? InkWell(
            onTap: (){
              Navigator.of(context).pushNamed("/addaddress", arguments: "new").then((value){
                setState(() {
                  if(value == "refresh") refreshIsRequired = true;
                });
              });
            },
            child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(Dictionairy.words["There are no Addesses"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, color: Colors.black.withOpacity(0.75)),),
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
                        Text(Dictionairy.words["Add Address"][UserInformation.language], style: GoogleFonts.almarai(color: Colors.black.withOpacity(0.75), fontSize: 20),),
                        Container(child: Icon(Icons.arrow_forward, color: Colors.black.withOpacity(0.75),), margin: EdgeInsets.only(left: 10),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          )
          : SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 600
              ),
              padding: EdgeInsets.only(
                top: 20,
                bottom: 15,
                left: 15,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < addresses.length; i++)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      bottom: 7.5,
                      top: 7.5,
                      left: 15,
                      right: 7.5,
                    ),
                    margin: EdgeInsets.only(bottom: 15),
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
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: ClipRect(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  child: Text(
                                    jsonDecode(Addresses.addressesBasket[i]["addresse"])["title"], 
                                    style: GoogleFonts.almarai(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ),
                                Text(
                                  Addresses.addressesBasket.isEmpty ? "" : "  " + jsonDecode(Addresses.addressesBasket[i]["addresse"])["store"], 
                                  style: GoogleFonts.almarai(fontSize: 14, height: 1.3),
                                ),
                                Text(
                                  Addresses.addressesBasket.isEmpty ? "" : "  " + jsonDecode(Addresses.addressesBasket[i]["addresse"])["location"]["latitude"].toStringAsFixed(5), 
                                  style: GoogleFonts.almarai(fontSize: 14, height: 1.3),
                                ),
                                Text(
                                  Addresses.addressesBasket.isEmpty ? "" : ", " + jsonDecode(Addresses.addressesBasket[i]["addresse"])["location"]["longitude"].toStringAsFixed(5), 
                                  style: GoogleFonts.almarai(fontSize: 14, height: 1.3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed("/addaddress", arguments: Addresses.addressesBasket[i]["ID"].toString()).then((value){  
                              setState(() {
                                if(value == "refresh") refreshIsRequired = true;
                              });
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            margin: EdgeInsets.only(
                              right: 5,
                              left: 5
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              gradient: LinearGradient(
                                colors: [Colors.blue.withOpacity(0.25), Colors.blue[50].withOpacity(0.25)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue[50],
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(2.5, 2.5),
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.edit_outlined, size: 25, color: Colors.blue,),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            bool waiting = false;
                            showDialog(context: context, builder: (BuildContext context){
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.yellow[50],
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 300
                                      ),
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 40, top: 20),
                                            child: Text(Dictionairy.words["Are you sure you want to delete this address ?"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(right: 10),
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black.withOpacity(0.1),
                                                        Colors.black.withOpacity(0.025),
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    )
                                                  ),
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.yellow[100],
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Text(Dictionairy.words["Cancel"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    waiting = true;
                                                  });
                                                  http.post(env.apiUrl + "/api/removeuseraddress", body: {
                                                    "sessionID": UserInformation.sessionID, 
                                                    "email": UserInformation.email, 
                                                    "addressID": addresses[i]["ID"].toString(),
                                                  }).then((value){
                                                    setState(() {
                                                      waiting = false;
                                                    });
                                                    Navigator.of(context).pop(true);
                                                  })
                                                  .catchError((onError){
                                                    Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
                                                  });
                                                  refreshIsRequired = true;
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black.withOpacity(0.1),
                                                        Colors.black.withOpacity(0.025),
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    )
                                                  ),
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.yellow[100],
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: !waiting ? Text(Dictionairy.words["Yes"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),) : Image.asset("assets/images/theLoading.gif", height: 18),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  );
                                }
                              );
                            }).then((value){
                              if (value == null) return;
                              // addresses.remove(addresses[i]);
                              setState(() {
                                Addresses.addressesBasket.remove(addresses[i]);                                              
                              });
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              gradient: LinearGradient(
                                colors: [Colors.red.withOpacity(0.25), Colors.red[50].withOpacity(0.25)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red[50],
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(2.5, 2.5),
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.delete_outline, size: 25, color: Colors.red,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
