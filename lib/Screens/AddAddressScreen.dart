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
  String mapButtonText = "Add Location";


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
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
      body: Container(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
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
                          hintText: "address name (ex: home)",
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
                          hintText: "additional information\nex: apartment number: 21",
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
                            print(value);
                            if (value != null) {
                              location = value;
                              mapButtonText = "location chosen";
                            }
                          });
                        });
                      },
                      child: Container(
                        height: 75,
                        margin: EdgeInsets.only(
                          top: 0,
                          bottom: 90,
                        ),
                        decoration: BoxDecoration(
                          color: mapButtonText == "location chosen" ? Colors.blue : Colors.white,
                          border: Border.all(
                            width: 4,
                            color: Colors.black.withOpacity(0.75),
                          ),
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
                              child: Icon(mapButtonText == "location chosen" ? Icons.done : Icons.add_location_alt, size: 40, color: mapButtonText == "location chosen" ? Colors.white : Colors.black,)
                            ),
                            Text(
                              mapButtonText,
                              style: TextStyle(
                                fontSize: 22.5,
                                color: mapButtonText == "location chosen" ? Colors.white : Colors.black,
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
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: (){
                  print("object");
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
                        child: Icon(Icons.save, size: 40,),
                      ),
                      Text("Save", style: TextStyle(fontSize: 25),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}