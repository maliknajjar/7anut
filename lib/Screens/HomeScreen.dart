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
  bool thereIsSelectedAddress = false;

  void requestData(){
    setState(() {
      dataIsAvailable = false;
      thereIsSelectedAddress = false;
    });
    http.post(env.apiUrl + "/api/favourite", body: {"email": UserInformation.email, "sessionID": UserInformation.sessionID}).then((re){
      Products.favourite = re.body == "" ? [] : re.body.split(",");
      http.get(env.apiUrl + "/api/categories").then((r){
        products = json.decode(r.body);
        Products.categories= json.decode(r.body);
      }).then((value){
        if (this.mounted) {
          http.post(env.apiUrl + "/api/getuseraddreses", body: {"email": UserInformation.email, "sessionID": UserInformation.sessionID})
          .then((value){
            if(jsonDecode(value.body).isEmpty){
              setState(() {
                dataIsAvailable = true;
                thereIsSelectedAddress = false;
              });
              return;
            }
            Addresses.addressesBasket = jsonDecode(value.body);
            // what happens when you fetch all needed data
            http.get(env.apiUrl + "/api/products/" + jsonDecode(Addresses.addressesBasket[0]["addresse"])["store"]).then((r){
              setState(() {
                dataIsAvailable = true;
                thereIsSelectedAddress = true;
                Products.products = json.decode(r.body);
              });
            });
          });
        }
      })
      .catchError((onError){
        Functions.logout(context, Dictionairy.words["Connection error"][UserInformation.language], Colors.red);
      });
    });
  }

  @override
  initState() {
    super.initState();

    TheWebSocket.connect(context);         // opening a websocket connection
    http.post(env.apiUrl + "/api/returnEverything", body: {"email": UserInformation.email, "sessionID": UserInformation.sessionID})      // making sure all products are returned before using tha app
    .then((thevalue){
      requestData();          // request categories and products from the server
    });
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
              child: !dataIsAvailable 
              ? Image.asset("assets/images/theLoading.gif", scale: 12, alignment: Alignment.centerRight,)
              : Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          thereIsSelectedAddress == false && dataIsAvailable == true 
          ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("there is no selected address", style: TextStyle(fontSize: 18)),
                Container(
                  child: InkWell(
                    onTap: (){
                      showDialogue();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12.5),
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            spreadRadius: 0,
                            offset: Offset(2, 2),
                            color: Colors.black.withOpacity(0.25)
                          )
                        ]
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(Dictionairy.words["Add Address"][UserInformation.language], style: GoogleFonts.almarai(fontWeight: FontWeight.bold, fontSize: 18),),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.add_location_alt_outlined),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
          : !dataIsAvailable 
          ? LoadingLogo() 
          : Center(
            child: Container(
              margin: EdgeInsets.only(top: 26),
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
                  top: theWidth < 600 ? (theWidth * 0.025) + 50 : 15 + 50,
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
                                color: Colors.white,
                                image: DecorationImage(
                                  image: ExactAssetImage("assets/images/loadingImage.gif"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(theWidth < 600 ? theWidth * 0.06 : 35),
                                ),
                                boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(products[i]["imageUrl"]),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(theWidth < 600 ? theWidth * 0.06 : 35),
                                  ),
                                  color: Colors.pink.withOpacity(0.0),
                                ),
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
            margin: EdgeInsets.only(
              right: theWidth < 600 ? theWidth * 0.025 : 15,
              left: theWidth < 600 ? theWidth * 0.025 : 15,
              top: 17.5,
            ),
            padding: EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                showDialogue();
              },
              child: Container(
                height: 45,
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
                    Flexible(
                      fit: FlexFit.loose,
                      child: ClipRect(
                        child: Row(
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
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_sharp, size: 28,)
                  ],
                ),
              ),
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
                        if (value == "refresh") requestData();
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
  void showDialogue(){
    bool islaoding = false;

    showDialog(context: context, builder: (BuildContext context){
      return StatefulBuilder(
        builder: (context, setState){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            backgroundColor: Colors.yellow[100],
            child: SingleChildScrollView(
              child: islaoding 
              ? Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Opacity(
                      opacity: 0.75,
                      child: Image.asset("assets/images/theLoading.gif", height: 100),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10
                      ),
                      child: Text(Dictionairy.words["Loading"][UserInformation.language] + "...", style: GoogleFonts.almarai(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              )
              : Container(
                constraints: BoxConstraints(
                  maxWidth: 300
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, "/addaddress").then((value){
                                setState(() {
                                  
                                });
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.yellow[50],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(2.5, 2.5),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(Dictionairy.words["Add Address"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, color: Colors.black.withOpacity(0.75)),),
                                  Container(child: Icon(Icons.add_location_alt_outlined, color: Colors.black.withOpacity(0.75),), margin: EdgeInsets.only(left: 10),)
                                ],
                              ),
                            ),
                          ),
                          Addresses.addressesBasket.length != 0
                          ? Container(
                            margin: EdgeInsets.only(bottom: 15, top: 20),
                            child: Text(Dictionairy.words["Addresses"][UserInformation.language] + ":", style: GoogleFonts.almarai(fontSize: 20),),
                          ) 
                          : Container(
                            padding: EdgeInsets.all(30),
                            alignment: Alignment.center,
                            child: Text(Dictionairy.words["There are no Addesses"][UserInformation.language], style: GoogleFonts.almarai(fontSize: 20, color: Colors.black.withOpacity(0.5)),)
                          ),
                          for (var i = 0; i < Addresses.addressesBasket.length; i++)
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                islaoding = true;
                              });
                              http.post(env.apiUrl + "/api/swapuseraddresses", body: {"email": UserInformation.email, "sessionID": UserInformation.sessionID, "top": Addresses.addressesBasket[0]["ID"].toString(), "bottom": Addresses.addressesBasket[i]["ID"].toString()})
                              .then((r){
                                Navigator.of(context).pop("changed");
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 15
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.yellow[50],
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.yellow[50],
                                    Colors.yellow[100],
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(2.5, 2.5),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: ClipRect(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            child: Text(
                                              jsonDecode(Addresses.addressesBasket[i]["addresse"])["title"], 
                                              style: GoogleFonts.almarai(fontWeight: FontWeight.bold, fontSize: 18),
                                            ),
                                          ),
                                          Text(
                                            Addresses.addressesBasket.isEmpty ? "" : "  " + jsonDecode(Addresses.addressesBasket[i]["addresse"])["store"], 
                                            style: GoogleFonts.almarai(fontSize: 14, height: 1.3),
                                          ),
                                          Text(
                                            Addresses.addressesBasket.isEmpty ? "" : "  " + jsonDecode(Addresses.addressesBasket[i]["addresse"])["location"]["latitude"].toStringAsFixed(5), 
                                            style: GoogleFonts.almarai(fontSize: 14, height: 1.3),
                                          ),
                                          Text(
                                            Addresses.addressesBasket.isEmpty ? "" : ", " + jsonDecode(Addresses.addressesBasket[i]["addresse"])["location"]["longitude"].toStringAsFixed(5), 
                                            style: GoogleFonts.almarai(fontSize: 14, height: 1.3),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.location_on_outlined)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        },
      );
    }).then((value){
      if(value == "changed"){
        Addresses.addressesBasket.clear();
        Basket.clearBasket();
        Basket.simpleArray.clear();
        http.post(env.apiUrl + "/api/returnEverything", body: {"email": UserInformation.email, "sessionID": UserInformation.sessionID})      // making sure all products are returned before using tha app
        .then((thevalue){
          requestData();          // request categories and products from the server
        });
        return;
      }
    });
  }
}
