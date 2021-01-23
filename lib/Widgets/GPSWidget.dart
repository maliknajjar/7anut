import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../Classes/Functions.dart';
import '../Classes/Adresses.dart';

class GPSAddAddress extends StatefulWidget {
  @override
  _GPSAddAddressState createState() => _GPSAddAddressState();
}

class _GPSAddAddressState extends State<GPSAddAddress> {
  String title;
  String information;
  String instructions;
  LatLng location;
  
  String mapButtonText = "Add Location";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 5
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
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed("/GetLocation").then((value){
                        setState(() {
                          print(value);
                          if (value != null) {
                            location = value;
                            mapButtonText = "Location Selected";
                          }
                        });
                      });
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(
                        top: 0,
                        bottom: 20,
                      ),
                      decoration: BoxDecoration(
                        color: location != null ? Colors.green : Colors.white,
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
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(location != null ? Icons.done : Icons.add_location_alt, size: 30, color: location != null ? Colors.white : Colors.black,)
                          ),
                          Text(
                            mapButtonText,
                            style: TextStyle(
                              fontSize: 22.5,
                              color: location != null ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 20,
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
                      minLines: 5,
                      onChanged: (string){
                        information = string;
                      },
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: "additional information (optional)\nex: apartment number: 21",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 20,
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
                if (location == null || title == null) Functions.alert(context, "Fields are empty", "You need to fill all the fields");
                else {
                  print(Addresses.addressesBasket);
                  Addresses.addAddress({"title": title, "information": information, "instructions": instructions, "location": {"latitude": location.latitude, "longitude": location.longitude}});
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