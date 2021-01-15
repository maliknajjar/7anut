import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../Classes/Functions.dart';

class GetLocationScreen extends StatefulWidget {
  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  MapboxMapController controller;
  LatLng theLocation;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  var symbol;
  void addPin({LatLng coord}) async{
    if (coord != null) theLocation = coord;
    else theLocation = controller.cameraPosition.target;

    if (symbol != null){
      controller.removeSymbol(symbol);
    }
    final ByteData bytes = await rootBundle.load("assets/images/thepin.png");
    final Uint8List list = bytes.buffer.asUint8List();
    await controller.addImage("pin", list);
    symbol = await controller.addSymbol(
      SymbolOptions(
        geometry: coord == null ? controller.cameraPosition.target : coord,
        iconImage: "pin",
        iconOffset: Offset(0, -20)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String token = 'pk.eyJ1IjoibWFsaWs0NDY2NDQiLCJhIjoiY2tqc2FzNnM5M3kwdzJzbG9pZjNwaGhoYyJ9.fvy5js-0tXvMXh5SrJWwLA';
    final String style = 'mapbox://styles/malik446644/ckjsiixy57o7r19oa0j65zen3';

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          MapboxMap(
            accessToken: token,
            styleString: style,
            initialCameraPosition: CameraPosition(
              zoom: 10.0,
              target: LatLng(36.8065, 10.1815),
            ),
            onMapCreated: (MapboxMapController controller){
              this.controller = controller;
            },
            trackCameraPosition: true,
          ),
          Positioned(
            top: 25 + 110.0,
            right: 25,
            child: InkWell(
              onTap: (){
                controller.animateCamera(CameraUpdate.zoomIn());
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Text("+", style: TextStyle(fontSize: 25),),
                ),
              ),
            ),
          ),
          Positioned(
            top: 90 + 110.0,
            right: 25,
            child: InkWell(
              onTap: (){
                controller.animateCamera(CameraUpdate.zoomOut());
                print("working");
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Text("-", style: TextStyle(fontSize: 25),),
                ),
              ),
            ),
          ),
          Positioned(
            top: 155 + 110.0,
            right: 25,
            child: InkWell(
              onTap: () async {
                print("working");
                determinePosition().then((value){
                  addPin(coord: LatLng(value.latitude, value.longitude));
                  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 15)));
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Icon(Icons.gps_fixed)
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(5),
                height: 60,
                width: width - 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.search, size: 30,),
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search'
                        ),
                        onSubmitted: (string){
                          http.get("https://api.mapbox.com/geocoding/v5/mapbox.places/$string.json?country=tn&access_token=pk.eyJ1IjoibWFsaWs0NDY2NDQiLCJhIjoiY2tqc2FzNnM5M3kwdzJzbG9pZjNwaGhoYyJ9.fvy5js-0tXvMXh5SrJWwLA")
                          .then((value){
                            print("woooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooow");
                            if (jsonDecode(value.body)["features"].length == 0){
                              print("no result");
                              Functions.alert(context, "no results", "didnt find any results");
                              return;
                            }
                            var coord = jsonDecode(value.body)["features"][0];
                            addPin(coord: LatLng(coord["center"][1], coord["center"][0]));
                            coord["bbox"] != null ? controller.animateCamera(CameraUpdate.newLatLngBounds(LatLngBounds(southwest: LatLng(coord["bbox"][1], coord["bbox"][0]), northeast: LatLng(coord["bbox"][3], coord["bbox"][2])))) : controller.animateCamera(CameraUpdate.newLatLng(LatLng(coord["center"][1], coord["center"][0])));
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 75,
              width: width,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        addPin();
                      },
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_location, size: 35,),
                            Text("Pin your location", style: TextStyle(fontSize: 20,),),
                          ],
                        )
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if (theLocation != null) Navigator.of(context).pop(theLocation);
                      else Functions.alert(context, "choose location", "you need to specify a location");
                    },
                    child: Container(
                      height: double.infinity,
                      margin: EdgeInsets.only(left: 10),
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Icon(Icons.done, size: 35,),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: Container(
                    color: Colors.black,
                    width: 15,
                    height: 3,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    color: Colors.black,
                    width: 15,
                    height: 3,
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    color: Colors.black,
                    width: 3,
                    height: 15,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Colors.black,
                    width: 3,
                    height: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
