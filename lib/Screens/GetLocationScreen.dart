import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';

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
              onTap: (){
                print("working");
                determinePosition().then((value){
                  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 10)));
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
                  child: Text("G", style: TextStyle(fontSize: 25),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
