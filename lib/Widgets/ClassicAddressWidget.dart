import 'dart:convert';

import 'package:flutter/material.dart';

import '../Classes/Functions.dart';
import '../Classes/Adresses.dart';

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
                      bottom: 15,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7.5,
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.25),
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
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: "address name | ex: home",
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 15,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7.5,
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint:  Text(state == null ? "state" : state, style: TextStyle(fontSize: 20),),
                        onChanged: (var value) {
                          setState(() {
                            state = value; 
                            city = null;                       
                          });
                        },
                        items: widget.cities.map((e){
                          return DropdownMenuItem(
                            value: e["state"],
                            child: Text(e["state"], style: TextStyle(fontSize: 20),)
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 15,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7.5,
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint:  Text(city == null ? "city" : city, style: TextStyle(fontSize: 20),),
                        onChanged: (var value) {
                          setState(() {
                            city = value;                        
                          });
                        },
                        items: state == null 
                        ? [
                          DropdownMenuItem(
                            value: null,
                            child: Text("Choose state", style: TextStyle(fontSize: 20),)
                          ),
                        ]
                        : jsonDecode(widget.cities[indexOfState(state)]["cities"]).map<DropdownMenuItem>((e){
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e, style: TextStyle(fontSize: 20),)
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 15,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7.5,
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.25),
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
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: "Street Address",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 15,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7.5,
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.25),
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
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: "Street Address 2 (optional)",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 15,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7.5,
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.25),
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
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: "instructions (optional)\nex: dont ring the bell",
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
                    "instructions": instructions
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                width: width,
                padding: EdgeInsets.all(15),
                color: Colors.yellow,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Icon(Icons.save, size: 30,),
                    ),
                    Text("Save", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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