import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/Classes/Adresses.dart';
import 'package:shop_app/Classes/UserInformation.dart';
import 'package:http/http.dart' as http;

import '../Classes/Adresses.dart';
import '../Classes/Dictionairy.dart';
import '../env.dart';

class AdressesScreen extends StatefulWidget {
  @override
  _AdressesScreenState createState() => _AdressesScreenState();
}

class _AdressesScreenState extends State<AdressesScreen> {

  @override
  Widget build(BuildContext context) {
    List addresses = Addresses.addressesBasket;

    return Scaffold(
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
              Navigator.of(context).pushNamed("/addaddress").then((value){
                setState(() {
                  
                });
              });
            },
          )
        ],
      ),
      body: addresses.isEmpty // check if there are addresses
        ? InkWell(
          onTap: (){
            Navigator.of(context).pushNamed("/addaddress").then((value){
              setState(() {
                              
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
                InkWell(
                  hoverColor: Colors.white.withOpacity(0),
                  focusColor: Colors.white.withOpacity(0),
                  highlightColor: Colors.white.withOpacity(0),
                  splashColor: Colors.white.withOpacity(0),
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context){
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 40,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20, top: 20),
                                      child: Text(Dictionairy.words["Address Information"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),),
                                    ),
                                    for (var item in jsonDecode(addresses[i]["addresse"]).values) /* loop information off an address from addresses array */
                                    Text(item),
                                    // item.toString().replaceAll("{", "").replaceAll("}", "").replaceAll("latitude: ", "").replaceAll("longitude: ", "").replaceAll(", ", "\n ")
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context, rootNavigator: true).pop();
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
                                        child: Text(Dictionairy.words["Ok"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      );
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      bottom: 10,
                      top: 10,
                      left: 15,
                      right: 15,
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
                        Container(
                          child: Text(jsonDecode(addresses[i]["addresse"])["title"], style: GoogleFonts.almarai(fontSize: 25),),
                        ),
                        GestureDetector(
                          onTap: (){
                            showDialog(context: context, builder: (BuildContext context){
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
                                              print("nice");
                                              // http.post(env.apiUrl + "/api/removeuseraddress", body: {"sessionID": UserInformation.sessionID, "email": UserInformation.email, "addressID": addresses[i]["ID"]})
                                              // .then((value){
                                                // print(value.body);
                                                // if (value.body != "success") return;
                                                // Navigator.of(context).pop(true);
                                              // });
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
                                                child: Text(Dictionairy.words["Yes"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
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
                              child: Icon(Icons.delete_outline, size: 30, color: Colors.red,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
