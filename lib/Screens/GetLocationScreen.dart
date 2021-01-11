import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class GetLocationScreen extends StatefulWidget {
  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  MapboxMapController controller;

  @override
  Widget build(BuildContext context) {
    final String token = 'pk.eyJ1IjoibWFsaWs0NDY2NDQiLCJhIjoiY2tqc2FzNnM5M3kwdzJzbG9pZjNwaGhoYyJ9.fvy5js-0tXvMXh5SrJWwLA';
    final String style = 'mapbox://styles/malik446644/ckjsbj4s07hy619pa7hbgf2lq';
    
    return Scaffold(
      body: Stack(
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
                controller.moveCamera(CameraUpdate.zoomOut());
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
                controller.moveCamera(CameraUpdate.zoomIn());
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
        ],
      ),
    );
  }
}
