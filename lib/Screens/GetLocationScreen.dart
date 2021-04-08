import 'dart:typed_data';
import 'dart:convert';
import 'dart:math' as Math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../Classes/UserInformation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/Dictionairy.dart';
import '../Classes/Functions.dart';

class GetLocationScreen extends StatefulWidget {
  List<dynamic> cities;
  List initCameraPosition;
  GetLocationScreen(List<dynamic> theCities, List initCamera){
    cities = theCities;
    initCameraPosition = initCamera;
  }
  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  MapboxMapController controller;
  LatLng theLocation;
  Circle circles;

  String theState;

  @override
  Widget build(BuildContext context) {
    final String token = 'pk.eyJ1IjoibWFsaWs0NDY2NDQiLCJhIjoiY2tqc2FzNnM5M3kwdzJzbG9pZjNwaGhoYyJ9.fvy5js-0tXvMXh5SrJWwLA';
    String style = 'mapbox://styles/malik446644/ckl98dh5k0oyg17mqozor6l0u';

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
              zoom: widget.initCameraPosition[2].toDouble(),
              target: LatLng(widget.initCameraPosition[0].toDouble(), widget.initCameraPosition[1].toDouble()),
            ),
            onStyleLoadedCallback: (){
              for (var i = 0; i < widget.cities.length; i++){
                drawTheCircle(controller, LatLng(widget.cities[i]["latitude"], widget.cities[i]["longitude"]), widget.cities[i]["radius"]);
              }
            },
            onMapCreated: (MapboxMapController controller) async{
              this.controller = controller;
            },
            trackCameraPosition: true,
          ),
          Positioned(
            top: 25 + 110.0,
            right: 25,
            child: InkWell(
              onTap: () async {
                await controller.animateCamera(CameraUpdate.zoomIn());
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.yellow[50],
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(5, 5)
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(Icons.add, size: 35,),
                ),
              ),
            ),
          ),
          Positioned(
            top: 90 + 110.0,
            right: 25,
            child: InkWell(
              onTap: () async {
                await controller.animateCamera(CameraUpdate.zoomOut());
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellow[50],
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(5, 5)
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Center(
                    child: Container(
                      width: 15,
                      height: 3,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 155 + 110.0,
            right: 25,
            child: InkWell(
              onTap: () async {
                determinePosition().then((value){
                  for (var i = 0; i < widget.cities.length; i++){
                    var cityCoord = widget.cities[i];
                    var radius = widget.cities[i]["radius"];
                    var distance = distanceBetweenTwoPoints(value.longitude, value.latitude, cityCoord["longitude"], cityCoord["latitude"]);
                    if(distance > radius){
                      if(i == widget.cities.length - 1){
                        // Functions.alert(context, "Not covered", "your location is not covered");
                        showDialog(context: context, builder: (BuildContext context){
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.yellow[50],
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 300
                              ),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 40,),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20, top: 20),
                                          child: Text(Dictionairy.words["your location is not covered"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context, rootNavigator: true).pop();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.1),
                                                Colors.black.withOpacity(0.025),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.yellow[100],
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(Dictionairy.words["Ok"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          );
                        });
                        return;
                      }
                    }else{
                      break;
                    }
                  }
                  addPin(coord: LatLng(value.latitude, value.longitude));
                  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 15)));
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellow[50],
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(5, 5)
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Icon(Icons.gps_fixed)
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(10),
                height: 60,
                width: width - 20,
                constraints: BoxConstraints(
                  maxWidth: 600
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow[50],
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(5, 5)
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15)
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
                          hintText: Dictionairy.words["Search"][UserInformation.language],
                          hintStyle: GoogleFonts.almarai()
                        ),
                        onSubmitted: (string){
                          http.get("https://api.mapbox.com/geocoding/v5/mapbox.places/$string.json?access_token=pk.eyJ1IjoibWFsaWs0NDY2NDQiLCJhIjoiY2tqc2FzNnM5M3kwdzJzbG9pZjNwaGhoYyJ9.fvy5js-0tXvMXh5SrJWwLA")
                          .then((value){
                            if (jsonDecode(value.body)["features"].length == 0){
                              // Functions.alert(context, "no results", "didnt find any results");
                              showDialog(context: context, builder: (BuildContext context){
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                  backgroundColor: Colors.yellow[50],
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 300
                                    ),
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 40,),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(bottom: 20, top: 20),
                                                child: Text(Dictionairy.words["didn not find any results"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                Navigator.of(context, rootNavigator: true).pop();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black.withOpacity(0.1),
                                                      Colors.black.withOpacity(0.025),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  )
                                                ),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.yellow[100],
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Text(Dictionairy.words["Ok"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                );
                              });
                              return;
                            }
                            var coord = jsonDecode(value.body)["features"][0];
                            addPin(coord: LatLng(coord["center"][1], coord["center"][0]));
                            coord["bbox"] != null ? controller.animateCamera(CameraUpdate.newLatLngBounds(LatLngBounds(southwest: LatLng(coord["bbox"][1], coord["bbox"][0]), northeast: LatLng(coord["bbox"][3], coord["bbox"][2])))) : controller.animateCamera(CameraUpdate.newLatLng(LatLng(coord["center"][1], coord["center"][0])));
                          })
                          .catchError((onError){
                            Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
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
              constraints: BoxConstraints(
                maxWidth: 600
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: double.infinity,
                      margin: EdgeInsets.only(right: 10),
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.yellow[50],
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 0,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(5, 5)
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Icon(Icons.arrow_back, size: 35,),),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        addPin(coord: controller.cameraPosition.target);
                      },
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.yellow[50],
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 0,
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(5, 5)
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_location_outlined, size: 35,),
                            Text(Dictionairy.words["choose this location"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20,),),
                          ],
                        )
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if (theLocation != null) Navigator.of(context).pop([theLocation, theState]);
                      // else Functions.alert(context, "choose location", "you need to specify a location");
                      else{
                        showDialog(context: context, builder: (BuildContext context){
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.yellow[50],
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 300
                              ),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 40,),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20, top: 20),
                                          child: Text(Dictionairy.words["you need to specify a location"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context, rootNavigator: true).pop();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.1),
                                                Colors.black.withOpacity(0.025),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.yellow[100],
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(Dictionairy.words["Ok"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          );
                        });
                      }
                    },
                    child: Container(
                      height: double.infinity,
                      margin: EdgeInsets.only(left: 10),
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.yellow[50],
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 0,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(5, 5)
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Icon(Icons.done, size: 35,),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 65,
            width: 65,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow[50],
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 3,
                          color: Colors.black.withOpacity(0.75),
                        )
                      ],
                      borderRadius: BorderRadius.circular(2.5)
                    ),
                    width: 20,
                    height: 3,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow[50],
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 3,
                          color: Colors.black.withOpacity(0.75),
                        )
                      ],
                      borderRadius: BorderRadius.circular(2.5)
                    ),
                    width: 20,
                    height: 3,
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow[50],
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 3,
                          color: Colors.black.withOpacity(0.75),
                        )
                      ],
                      borderRadius: BorderRadius.circular(2.5)
                    ),
                    width: 3,
                    height: 20,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow[50],
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 3,
                          color: Colors.black.withOpacity(0.75),
                        )
                      ],
                      borderRadius: BorderRadius.circular(2.5)
                    ),
                    width: 3,
                    height: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

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

  double distanceBetweenTwoPoints(double x1, double y1, double x2, double y2){
    double x = x1 - x2;
    double y = y1 - y2;
    return Math.sqrt((x*x)+(y*y));
  }

  var symbol;
  void addPin({LatLng coord}) async{
    for (var i = 0; i < widget.cities.length; i++){
      var cityCoord = widget.cities[i];
      var radius = widget.cities[i]["radius"];
      var distance = distanceBetweenTwoPoints(coord.longitude, coord.latitude, cityCoord["longitude"], cityCoord["latitude"]);
      if(distance > radius){
        if(i == widget.cities.length - 1){
          // Functions.alert(context, "Not covered", "your location is not covered");
          showDialog(context: context, builder: (BuildContext context){
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              backgroundColor: Colors.yellow[50],
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 300,
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40,),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20, top: 20),
                            child: Text(Dictionairy.words["your location is not covered"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20),),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.025),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(Dictionairy.words["Ok"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 16),),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            );
          });
          return;
        }
      }else{
        theState = widget.cities[i]["store_name"];
        break;
      }
    }

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
        iconOffset: kIsWeb ? Offset(0, -73) : Offset(0, -27),
        iconSize: kIsWeb ? 0.5 : null,
      ),
    );
    theLocation = coord;
  }
}

void drawTheCircle(MapboxMapController controller, LatLng center, double radius) async {
  await controller.addFill(FillOptions(
    fillColor: '#fff700',
    fillOpacity: 0.1,
    geometry: [
      circlePoints(center, radius),
    ]
  ));
  await controller.addLine(LineOptions(
    lineColor: '#fff700',
    lineWidth: 3,
    geometry: circlePoints(center, radius),
  ));
}

List<LatLng> circlePoints(LatLng center, double radius){
  List<LatLng> coords = [LatLng(center.latitude + radius, center.longitude)];
  LatLng newPoint = coords[0];
  double circleResolution = 1; // the smaller the better (only devided by two)
  for (double i = 0; i < 360; i += circleResolution) {
    newPoint = rotatePoint(center.longitude, center.latitude, newPoint.longitude, newPoint.latitude, circleResolution.toDouble());
    coords.add(newPoint);
  }
  return coords;
}

LatLng rotatePoint(double cx, double cy, double px, double py, double degree) {
  double radians = degree * Math.pi / 180;

  var x1 = (px - cx) * Math.cos(radians) - (py - cy) * Math.sin(radians) + cx;
  var y1 = (px - cx) * Math.sin(radians) + (py - cy) * Math.cos(radians) + cy;

  return LatLng(y1, x1);
}