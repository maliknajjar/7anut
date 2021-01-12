import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetLocationScreen extends StatefulWidget {
  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  MapboxMapController controller;

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

  @override
  Widget build(BuildContext context) {
    final String token = 'pk.eyJ1IjoibWFsaWs0NDY2NDQiLCJhIjoiY2tqc2FzNnM5M3kwdzJzbG9pZjNwaGhoYyJ9.fvy5js-0tXvMXh5SrJWwLA';
    final String style = 'mapbox://styles/malik446644/ckjsiixy57o7r19oa0j65zen3';

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Circle theCircle;
    
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
            bottom: 25,
            right: 25,
            child: InkWell(
              onTap: (){
                controller.animateCamera(CameraUpdate.zoomOut());
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
            bottom: 90,
            right: 25,
            child: InkWell(
              onTap: (){
                controller.animateCamera(CameraUpdate.zoomIn());
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
                  child: Text("+", style: TextStyle(fontSize: 25),),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 155,
            right: 25,
            child: InkWell(
              onTap: () async {
                print("working");
                // determinePosition().then((value){
                //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 15)));
                // });
                if (theCircle != null) controller.removeCircle(theCircle);
                theCircle = await controller.addCircle(
                  CircleOptions(
                    circleRadius: 8.0,
                    circleColor: 'red',
                    circleOpacity: 0.8,
                    geometry: controller.cameraPosition.target,
                    draggable: false,
                  ),
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Text("G", style: TextStyle(fontSize: 25),),
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
                          http.get("https://api.mapbox.com/geocoding/v5/mapbox.places/$string.json?access_token=pk.eyJ1IjoibWFsaWs0NDY2NDQiLCJhIjoiY2tqc2FzNnM5M3kwdzJzbG9pZjNwaGhoYyJ9.fvy5js-0tXvMXh5SrJWwLA")
                          .then((value){
                            print("woooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooow");
                            var coord = jsonDecode(value.body)["features"][0]["bbox"];
                            controller.animateCamera(CameraUpdate.newLatLngBounds(LatLngBounds(southwest: LatLng(coord[1], coord[0]), northeast: LatLng(coord[3], coord[2]))));
                          });
                        },
                      ),
                    ),
                  ],
                ),
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
