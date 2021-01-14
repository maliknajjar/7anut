import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String title;
  String information;
  LatLng location;
  String mapButtonText = "Pick Address Location";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xFF303030),
        ),
        title: Text(
          "Add Adresse",
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
        backgroundColor: Color(0xFF5DA7E6),
      ),
      body: SingleChildScrollView(
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
                    hintText: "address name (ex: work)",
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
                    hintText: "additional information\n\nex: Building name: zouhour, \napartment number: 21",
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
                    hintText: "instructions for delivery guy\nex: dont ring the bell",
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed("/GetLocation").then((value){
                    setState(() {
                      if (value != null || value != "") mapButtonText = value;
                    });
                  });
                },
                child: Container(
                  height: 75,
                  margin: EdgeInsets.only(
                    top: 0,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 5,
                      color: Colors.black.withOpacity(0.75),
                    ),
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
                  child: Center(
                    child: Text(
                      mapButtonText,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}