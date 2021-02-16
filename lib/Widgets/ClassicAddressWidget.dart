import 'dart:convert';

import 'package:flutter/material.dart';

import '../Classes/Functions.dart';
import '../Classes/Adresses.dart';
import '../Classes/UserInformation.dart';
import '../Classes/Dictionairy.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassicAddressWidget extends StatefulWidget {
  List<dynamic> cities;
  ClassicAddressWidget(List<dynamic> theCities){
    cities = theCities;
  }
  @override
  _ClassicAddressWidgetState createState() => _ClassicAddressWidgetState();
}

class _ClassicAddressWidgetState extends State<ClassicAddressWidget> {
  String title;
  String streetAddress;
  String streetAddress2;
  String state;
  String city;
  String instructions;

  int indexOfState(String stateName){
    for (var i = 0; i < widget.cities.length; i++) {
      if(stateName == widget.cities[i]["state"]) return i;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 50,
            ),
            child: Container(
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
                        width: double.infinity,
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint:  Text(state == null ? Dictionairy.words["state"][UserInformation.language] : state, style: GoogleFonts.almarai(fontSize: 20),),
                            onChanged: (var value) {
                              setState(() {
                                state = value; 
                                city = null;                       
                              });
                            },
                            items: widget.cities.map((e){
                              return DropdownMenuItem(
                                value: e["state"],
                                child: Text(e["state"], style: GoogleFonts.almarai(fontSize: 20),)
                              );
                            }).toList(),
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
                        width: double.infinity,
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint:  Text(city == null ? Dictionairy.words["city"][UserInformation.language] : city, style: GoogleFonts.almarai(fontSize: 20),),
                            onChanged: (var value) {
                              setState(() {
                                city = value;                        
                              });
                            },
                            items: state == null 
                            ? [
                              DropdownMenuItem(
                                value: null,
                                child: Text(Dictionairy.words["Choose state"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),)
                              ),
                            ]
                            : jsonDecode(widget.cities[indexOfState(state)]["cities"]).map<DropdownMenuItem>((e){
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e, style: GoogleFonts.almarai(fontSize: 20),)
                              );
                            }).toList(),
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
                          onChanged: (string){
                            streetAddress = string;
                          },
                          style: GoogleFonts.almarai(
                            fontSize: 20,
                          ),
                          cursorColor: Colors.black54,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            hintText: Dictionairy.words["Address"][UserInformation.language],
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
                          onChanged: (string){
                            streetAddress2 = string;
                          },
                          style: GoogleFonts.almarai(
                            fontSize: 20,
                          ),
                          cursorColor: Colors.black54,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            hintText: Dictionairy.words["Address 2 (optional)"][UserInformation.language],
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: (){
                print("save");
                if (title == null || streetAddress == null ||  state == null || city == null) Functions.alert(context, "Fields are empty", "You need to fill all the fields");
                else {
                  print(Addresses.addressesBasket);
                  Addresses.addAddress({
                    "title": title,
                    "state": state,
                    "city": city,
                    "streetAddress": streetAddress,
                    "streetAddress2": streetAddress2,
                    "instructions": instructions,
                    "email": UserInformation.email
                  });
                  Navigator.of(context).pop();
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Icon(Icons.save, size: 30,),
                    ),
                    Text(Dictionairy.words["Save"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}