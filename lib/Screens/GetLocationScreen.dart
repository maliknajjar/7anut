import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class GetLocationScreen extends StatelessWidget {
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
              zoom: 3.0,
              target: LatLng(36.8065, 10.1815),
            ),
          ),
          Positioned(
            bottom: 25,
            right: 25,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Center(
                child: Text("+"),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 25,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Center(
                child: Text("+"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
