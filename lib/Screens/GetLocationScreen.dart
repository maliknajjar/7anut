import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class GetLocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xFF303030),
        ),
        title: Text(
          "Adresses",
          style: TextStyle(
            color: Color(0xFF303030),
          ),
        ),
        backgroundColor: Color(0xFF5DA7E6),
      ),
      body: MapboxMap(
        accessToken: "pk.eyJ1IjoibWFsaWs0NDY2NDQiLCJhIjoiY2tqcmFsNjh2M2N6bDJ0cW9xdXprM3dsciJ9.AJyHupCTovVbfLArWFDKEQ",
        styleString: 'url-to-style',
        initialCameraPosition: CameraPosition(
          zoom: 15.0,
          target: LatLng(14.508, 46.048),
        ),
      ),
    );
  }
}
