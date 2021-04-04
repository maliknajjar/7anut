import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import '../Screens/LoadingLogoScreen.dart';
import '../Widgets/DrawerWidget.dart';
import '../env.dart';

import '../Classes/Procucts.dart';
import '../Classes/Functions.dart';
import '../Classes/Dictionairy.dart';
import '../Classes/TheWebSocket.dart';
import '../Classes/Basket.dart';
import '../Classes/Adresses.dart';
import '../Classes/UserInformation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var products;
  bool dataIsAvailable = false;

  void requestData(){
    setState(() {
      dataIsAvailable = false;
    });
    http.get(env.apiUrl + "/api/categories").then((r){
      products = json.decode(r.body);
      Products.categories= json.decode(r.body);
    }).then((value){
      http.get(env.apiUrl + "/api/products/").then((r){
        if (this.mounted) {
          http.post(env.apiUrl + "/api/getuseraddreses", body: {"email": UserInformation.email, "sessionID": UserInformation.sessionID})
          .then((value){
            Addresses.addressesBasket = jsonDecode(value.body);
            // what happens when you fetch all needed data
            setState(() {
              dataIsAvailable = true;
              Products.products = json.decode(r.body);
            });
          });
        }
      });
    })
    .catchError((onError){
      print("Catch error");
      print(onError);
      Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
    });
  }

  @override
  initState() {
    super.initState();

    TheWebSocket.connect(context);         // opening a websocket connection
    requestData();                        // request categories and products from the server
  }

  @override
  Widget build(BuildContext context) {
    var theWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: TheDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.75),
        ),
        centerTitle: true,
        title: Image.asset(
          "assets/images/logo-01.png", 
          height: 25,
        ),
        backgroundColor: Colors.yellow[200],
        actions: [
          GestureDetector(
            onTap: (){
              requestData();
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          !dataIsAvailable ? LoadingLogo() : Center(
            child: Container(
              margin: EdgeInsets.only(top: 75),
              padding: EdgeInsets.only(
                bottom: 54.5,
              ),
              color: Colors.white,
              constraints: BoxConstraints(
                maxWidth: 600
              ),
              child: GridView.count(
                padding: EdgeInsets.only(
                  bottom: 15,
                  top: theWidth < 600 ? theWidth * 0.025 : 15,
                  right: theWidth < 600 ? theWidth * 0.025 : 15,
                  left: theWidth < 600 ? theWidth * 0.025 : 15,
                ),
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                crossAxisCount: 4,
                childAspectRatio: 0.64,
                children: <Widget>[
                  for (var i = 0; i < products.length; i++)
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/category", arguments: i).then((value){
                        if(value == "refresh"){
                          requestData();
                          return;
                        }
                        setState(() {
                                              
                        });
                      });
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(products[i]["imageUrl"]),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(theWidth < 600 ? theWidth * 0.06 : 35),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              top: 2.5,
                            ),
                            child: Center(
                              child: Text(
                                jsonDecode(products[i]["name"])[UserInformation.language],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.almarai(fontSize: theWidth < 600 ? theWidth * 0.04 : 21),
                              ),
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
          Container(
            height: 45,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 25,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12.5,
            ),
            constraints: BoxConstraints(
              maxWidth: 600
            ),
            decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7.5,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(2.5, 2.5),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.gps_fixed_outlined),
                    Container(
                      margin: EdgeInsets.only(left: 7.5),
                      child: Text(
                        Addresses.addressesBasket.isEmpty && !dataIsAvailable ? Dictionairy.words["Loading"][UserInformation.language] + "..." : Addresses.addressesBasket.isEmpty ? Dictionairy.words["Add Address"][UserInformation.language] : jsonDecode(Addresses.addressesBasket[0]["addresse"])["title"], 
                        style: GoogleFonts.almarai(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Text(
                      Addresses.addressesBasket.isEmpty ? "" : "  " + jsonDecode(Addresses.addressesBasket[0]["addresse"])["store"], 
                      style: GoogleFonts.almarai(fontSize: 14, height: 1.3),
                    ),
                    Text(
                      Addresses.addressesBasket.isEmpty ? "" : "  " + jsonDecode(Addresses.addressesBasket[0]["addresse"])["location"]["latitude"].toStringAsFixed(5), 
                      style: GoogleFonts.almarai(fontSize: 14, height: 1.3),
                    ),
                    Text(
                      Addresses.addressesBasket.isEmpty ? "" : ", " + jsonDecode(Addresses.addressesBasket[0]["addresse"])["location"]["longitude"].toStringAsFixed(5), 
                      style: GoogleFonts.almarai(fontSize: 14, height: 1.3),
                    ),
                  ],
                ),
                Icon(Icons.keyboard_arrow_down_sharp, size: 28,)
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            width: theWidth,
            height: 55,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/profile")
                      .then((value){
                        setState(() {
                                                  
                        });
                      });
                    },
                    child: Icon(
                      Icons.person_outline,
                      size: 35,
                      color: Color(0xFF303030),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/search").then((value){
                        setState(() {
                                                  
                        });
                      });
                    },
                    child: Icon(
                      Icons.search,
                      size: 35,
                      color: Color(0xFF303030),
                    ),
                  ),
                  // NULL space for design \/ \/ \/ \/ \/
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Icon(Icons.ac_unit),
                  ),
                  // NULL space for design /\ /\ /\ /\ /\
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/adresses").then((value){
                        requestData();
                      });
                    },
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 35,
                      color: Color(0xFF303030),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/orders");
                    },
                    child: Icon(
                      Icons.access_time,
                      size: 35,
                      color: Color(0xFF303030),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: -5,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/basket").then((value){
                    setState(() {
                                          
                    });
                  });
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      ),
                    ],
                    shape: BoxShape.circle,  
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 35,
                        color: Colors.black.withOpacity(0.75),
                      ),
                      int.parse(Basket.getItemsTotalTypeNumber()) == 0 ? Text("") : Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 22.5,
                          width: 22.5,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                          ),
                          child: Center(child: Text(Basket.getItemsTotalTypeNumber(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
