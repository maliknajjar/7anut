import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
import '../Classes/UserInformation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/Adresses.dart';
import '../Classes/UserInformation.dart';
import './LoadingLogoScreen.dart';
import '../Screens/GetLocationScreen.dart';
import '../Classes/Dictionairy.dart';
import '../Classes/Functions.dart';
import '../env.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String title;
  String information;
  String instructions;
  LatLng location;
  String mapButtonText = Dictionairy.words["Add Location"][UserInformation.language];
  String theState;

  bool isWaiting = false;

  bool isDataHere = false;
  List<dynamic> r;
  List initCamera;

  @override
  void initState() {
    super.initState();

    http.get(env.apiUrl + "/api/stores")
    .then((value){
      http.get(env.apiUrl + "/api/initialcameraposition")
      .then((v){
        initCamera = jsonDecode(v.body);
        r = jsonDecode(value.body);
        setState(() {
          isDataHere = true;
        });
      });
    })
    .catchError((onError){
      Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.yellow[200],
          iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.75),
          ),
          title: Text(
            Dictionairy.words["Add Address"][UserInformation.language],
            style: GoogleFonts.almarai(
              color: Colors.black.withOpacity(0.75),
            ),
          ),
        ),
        body: !isDataHere ? LoadingLogo() : Container(
          height: double.infinity,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 50
                ),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 600
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 0,
                            bottom: 20,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 0,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(5, 5)
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow[50],
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                  BoxShadow(
                                    spreadRadius: 4,
                                    blurRadius: 5,
                                    color: Colors.white,
                                    offset: Offset(10, 10)
                                  ),
                                  BoxShadow(
                                    spreadRadius: -5,
                                    blurRadius: 20,
                                    color: Colors.yellow[100],
                                    offset: Offset(-5, -2.5)
                                  ),
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextField(
                                onChanged: (string){
                                  title = string;
                                },
                                style: GoogleFonts.almarai(
                                  fontSize: 20,
                                ),
                                cursorColor: Colors.black54,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  hintText: Dictionairy.words["address name | ex: home"][UserInformation.language],
                                  hintStyle: GoogleFonts.almarai()
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetLocationScreen(r, initCamera))).then((value){
                              setState(() {
                                if (value != null) {
                                  location = value[0];
                                  theState = value[1];
                                  mapButtonText = Dictionairy.words["Location Selected"][UserInformation.language];
                                }
                              });
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 0,
                              bottom: 20,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(5, 5)
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                      BoxShadow(
                                        color: Colors.yellow[50],
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                      BoxShadow(
                                        spreadRadius: 4,
                                        blurRadius: 5,
                                        color: Colors.white,
                                        offset: Offset(10, 10)
                                      ),
                                      BoxShadow(
                                        spreadRadius: -5,
                                        blurRadius: 20,
                                        color: Colors.yellow[100],
                                        offset: Offset(-5, -2.5)
                                      ),
                                    ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Icon(location != null ? Icons.done : Icons.add_location_alt_outlined, size: 30, color: Colors.black.withOpacity(0.75),)
                                    ),
                                    Text(
                                      mapButtonText,
                                      style: GoogleFonts.almarai(
                                        fontSize: 22.5,
                                        color: Colors.black.withOpacity(0.75),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 0,
                            bottom: 20,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 0,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(5, 5)
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow[50],
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                  BoxShadow(
                                    spreadRadius: 4,
                                    blurRadius: 5,
                                    color: Colors.white,
                                    offset: Offset(10, 10)
                                  ),
                                  BoxShadow(
                                    spreadRadius: -5,
                                    blurRadius: 20,
                                    color: Colors.yellow[100],
                                    offset: Offset(-5, -2.5)
                                  ),
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                minLines: 5,
                                onChanged: (string){
                                  information = string;
                                },
                                style: GoogleFonts.almarai(
                                  fontSize: 20,
                                ),
                                cursorColor: Colors.black54,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  hintText: Dictionairy.words["additional information (optional)\nex: apartment number: 21"][UserInformation.language],
                                  hintStyle: GoogleFonts.almarai(height: 1.5)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 0,
                            bottom: 20,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 0,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(5, 5)
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow[50],
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                  BoxShadow(
                                    spreadRadius: 4,
                                    blurRadius: 5,
                                    color: Colors.white,
                                    offset: Offset(10, 10)
                                  ),
                                  BoxShadow(
                                    spreadRadius: -5,
                                    blurRadius: 20,
                                    color: Colors.yellow[100],
                                    offset: Offset(-5, -2.5)
                                  ),
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                minLines: 3,
                                onChanged: (string){
                                  instructions = string;
                                },
                                style: GoogleFonts.almarai(
                                  fontSize: 20,
                                ),
                                cursorColor: Colors.black54,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  hintText: Dictionairy.words["instructions (optional)\nex: dont ring the bell"][UserInformation.language],
                                  hintStyle: GoogleFonts.almarai(height: 1.5)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: GestureDetector(
                  onTap: (){
                    if (location == null || title == null){
                      // Functions.alert(context, "Fields are empty", "You need to fill all the fields");
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
                                  child: Text(Dictionairy.words["Make sure to fill all the fields"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).pop();
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
                    }
                    else {
                      setState(() {
                        isWaiting = true;                  
                      });
                      Map address = {
                        "title": title, 
                        "store": theState,
                        "location": {"latitude": location.latitude, "longitude": location.longitude}, 
                        "information": information, 
                        "instructions": instructions,
                      };
                      http.post(env.apiUrl + "/api/createuseraddress", body: {
                        "sessionID": UserInformation.sessionID,
                        "email": UserInformation.email, 
                        "address": jsonEncode(address)
                      }).then((value){
                        setState(() {
                          isWaiting = false;
                        });
                        Addresses.addressesBasket.add({
                          "ID": jsonDecode(value.body)["insertId"],
                          "userEmail": UserInformation.email,
                          "addresse": jsonEncode(address),
                        });
                        Navigator.of(context).pop();
                      }).catchError((onError){
                        Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
                      });
                    }
                  },
                  child: Container(
                    width: width,
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
                    child: !isWaiting
                    ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(Icons.save, size: 30, color: Colors.black.withOpacity(0.75),),
                        ),
                        Text(Dictionairy.words["Save"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75)),),
                      ],
                    )
                    : Image.asset("assets/images/theLoading.gif", height: 30),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}